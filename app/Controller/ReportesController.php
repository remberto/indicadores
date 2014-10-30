<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
App::uses('AppController', 'Controller');
App::uses('HttpSocket', 'Network/Http');
/**
 */
class ReportesController extends AppController{
    var $name = 'Reportes';//inicializacion de variables
    public $components = array('RequestHandler');
    public $uses = array('Reporte');
    //funcion de inicio


    public function index() {
        if(isset($this->request->query['reporte_id'])):
            $datas = $this->Reporte->find('all',array('conditions'=>array('Reporte.panel_id'=>$this->request->query['reporte_id']),
                                                      'order'=>array('Reporte.id')));
            $reportes = array();
            foreach($datas as $data):
               $reporte = array();
               foreach ($data as $key => $val):                
                 foreach ($val as $key => $value):
                    $reporte[$key] = $value;
                 endforeach;                
               endforeach;
               array_push($reportes, $reporte);
            endforeach;
        else:
            $datas = $this->Reporte->find('all',array('order'=>array('Reporte.id')));
            $reportes = array();
            foreach($datas as $data):
               $reporte = array();
               foreach ($data as $key => $val):                
                  foreach ($val as $key => $value):
                     $reporte[$key] = $value;
                  endforeach;                
               endforeach;
               array_push($reportes, $reporte);
            endforeach;
        endif;
        $this->set(array(
            'reportes' => $reportes,
            '_serialize' => array('reportes')
        ));       
    }

    public function view($id){

//$this->layout = 'json';
        header("Pragma: no-cache");
        header("Cache-Control: no-store, no-cache, max-age=0, must-revalidate");
        header('Content-Type: application/json');
        header('Access-Control-Allow-Origin: *');
        // Buscar el query
        $query_search = $this->Reporte->find('first', array(
            'conditions'=>array('Reporte.id'=>$id)));
        
        foreach($query_search['Parametros'] as $parametro):
          if($parametro['tipo'] == 'int'):
             $query_search['Reporte']['query'] = str_replace(':'.$parametro['parametro'], $this->request->query[$parametro['parametro']],  $query_search['Reporte']['query']);
          elseif($parametro['tipo'] == 'str'):
             $query_search['Reporte']['query'] = str_replace(':'.$parametro['parametro'], '\''.$this->request->query[$parametro['parametro']].'\'', $query_search['Reporte']['query']);
          endif;
        endforeach;
        
        
        // Selecciona las cotizaciones
        $query = $this->Reporte->query($query_search['Reporte']['query']);
 
        
        
        if((strcmp($query_search['Reporte']['tipo_grafico'],'bar') == 0) || 
        (strcmp($query_search['Reporte']['tipo_grafico'],'line') == 0) || 
        (strcmp($query_search['Reporte']['tipo_grafico'],'column') == 0)):
            $categorias = array();
            $categorias_calculo = array();
            $data = array();
            // Envia la dimension tiempo en un array
            foreach ($query as $datos):
                foreach ($datos as $dato):
                     $data[$dato['categoria']][$dato['serie_id']] = $dato['valor'];
                     if(!in_array($dato['serie'], $categorias)):
                         array_push($categorias, $dato['serie']);
                     endif;
                     if(!in_array($dato['serie_id'], $categorias_calculo)):
                         array_push($categorias_calculo, $dato['serie_id']);
                     endif;
                endforeach;            
            endforeach;
        
            $series = array();
            foreach($data as $key => $row):
                $init = $categorias_calculo[0];
                $cell = array_fill(0, count($categorias_calculo), 0);
                $i = 0;
                foreach($categorias_calculo as $fila):
                    if(isset($row[$fila])):
                        $cell[$i++] = round($row[$fila],2);
                    endif;
                endforeach;
                $row = array('name' => $key, 'data' => $cell);
                array_push($series, $row);
            endforeach;
            //die();


            $datos = array();
            $datos['title']['text'] = $query_search['Reporte']['titulo'];
            $datos['subtitle']['text'] = $query_search['Reporte']['subtitulo'];
            $datos['options']['chart']['type'] = $query_search['Reporte']['tipo_grafico'];
            if(($query_search['Reporte']['tipo_grafico'] == 'column') &&
               isset($query_search['Reporte']['subtipo_grafico']) &&
               !empty($query_search['Reporte']['subtipo_grafico'])):
	    	$datos['options']['plotOptions']['series']['stacking'] = $query_search['Reporte']['subtipo_grafico'];
		$datos['options']['plotOptions']['series']['dataLabels']['enabled'] = true;
		$datos['yAxis']['stackLabels']['enabled'] = true;
	    endif;
	    $datos['ayuda'] = $query_search['Reporte']['ayuda'];
            $datos['yAxis']['title']['text'] = $query_search['Reporte']['y_titulo'];
            $datos['xAxis']['categories'] = $categorias;
            $datos['xAxis']['title']['text'] = $query_search['Reporte']['x_titulo'];
            $datos['series'] = $series;
      elseif(strcmp($query_search['Reporte']['tipo_grafico'],'pie') == 0):
            $series = array();
            // Envia la dimension tiempo en un array
            foreach ($query as $datos):
                foreach ($datos as $dato):
                   $row = array('name'=> $dato['serie'], 'y' => (float)$dato['valor']);
                   //array_push($series, (float)$dato['valor']);
                   array_push($series, $row);
                endforeach;            
            endforeach;
	    //die();

            $datos = array();
            $datos['title']['text'] = $query_search['Reporte']['titulo'];
            $datos['subtitle']['text'] = $query_search['Reporte']['subtitulo'];
            $datos['options']['chart']['type'] = $query_search['Reporte']['tipo_grafico'];
            $datos['options']['tooltip']['pointFormat'] = $query_search['Reporte']['ayuda'];
            $datos['options']['plotOptions']['pie']['dataLabels']['enabled'] = true;
            $datos['options']['plotOptions']['pie']['dataLabels']['format'] = $query_search['Reporte']['format_help'];
            $datos['series'][0]['name'] = $query_search['Reporte']['y_titulo'];
            $datos['series'][0]['data'] = $series;
      elseif(strcmp($query_search['Reporte']['tipo_grafico'],'map') == 0):
            $series = array();
            // Envia la dimension tiempo en un array
            foreach ($query as $datos):
                foreach ($datos as $dato):
                    $row = array('hc-key'=> $dato['serie'], 'value' => (float)$dato['valor']);
                    array_push($series, $row);
                endforeach;            
            endforeach;
            $datos = array();
            $datos['title']['text'] = $query_search['Reporte']['titulo'];
            $datos['subtitle']['text'] = $query_search['Reporte']['subtitulo'];
            $datos['options']['chart']['type'] = $query_search['Reporte']['tipo_grafico'];
            $datos['ayuda'] = $query_search['Reporte']['ayuda'];
            $datos['yAxis']['title']['text'] = $query_search['Reporte']['y_titulo'];
            $datos['series'] = $series;
      elseif(strcmp($query_search['Reporte']['tipo_grafico'],'cuadro') == 0):
            $series = array();
            // Envia la dimension tiempo en un array
            foreach ($query as $datos):
                foreach ($datos as $dato):
                    $row = array('name'=> $dato['serie'], 'y' => (float)$dato['valor']);
                    array_push($series, $row);
                endforeach;            
            endforeach;
            $datos = array();
            $datos['title']['text'] = $query_search['Reporte']['titulo'];
            $datos['subttle']['text'] = $query_search['Reporte']['subtitulo'];
            $datos['options']['chart']['type'] = $query_search['Reporte']['tipo_grafico'];
            $datos['ayuda'] = $query_search['Reporte']['ayuda'];
            $datos['y_titulo'] = $query_search['Reporte']['y_titulo'];
            $datos['background'] = $query_search['Reporte']['background'];
            $datos['icono'] = $query_search['Reporte']['icono'];
            $datos['url'] = $query_search['Reporte']['url'];
            $datos['series'] = $series;
      endif;
      $this->set('datos',$datos);
      $this->set(compact('datos'));
      // retorna en JSON los datos de cotizaciones
      $this->set('_serialize', array('datos'));
    }


    public function add(){
       
        /*$link =  "http://localhost:8080/Estudiante";
        
        $data = json_encode($this->request->data['Persona']);
        $httpSocket = new HttpSocket();
        $response = $httpSocket->post($link, $data );*/

        /*$this->set(array(
            'message' => $message,
            '_serialize' => array('message')
        ));*/
    }

    public function delete($id){
    	/*
        if($this->Estudiante->delete($id)):
		  $message = 'Eliminado';
	    else:
		  $message = 'Error';
	    endif;
	    $this->set(array(
            'message' => $message,
            '_serialize' => array('message')
           ));*/
    }        

}
?>