<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
App::uses('AppController', 'Controller');
App::uses('HttpSocket', 'Network/Http');
/**
 */
class TablesController extends AppController{
    var $name = 'Tables';//inicializacion de variables
    public $components = array('RequestHandler');
    public $uses = array('Table');
    //funcion de inicio


    public function view($id){

//$this->layout = 'json';
        header("Pragma: no-cache");
        header("Cache-Control: no-store, no-cache, max-age=0, must-revalidate");
        header('Content-Type: application/json');
        header('Access-Control-Allow-Origin: *');
        // Buscar el query
        $query_search = $this->Table->find('first', array(
            'conditions'=>array('Table.query_id'=>$id)));
                
        // Selecciona las cotizaciones
        $datas = $this->Table->query($query_search['Table']['query']);
        $datos = array();
        foreach($datas as $data):
            $dato = array();
            foreach ($data as $key => $val):                
                foreach ($val as $key => $value):
                  $dato[$key] = $value;
                endforeach;                
            endforeach;
            array_push($datos, $dato);
        endforeach;

        $this->set('datos',$datos);
        $this->set(compact('datos'));
        // retorna en JSON los datos de cotizaciones
        $this->set('_serialize', array('datos'));
    }

}
?>