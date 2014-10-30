<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
App::uses('AppController', 'Controller');
App::uses('HttpSocket', 'Network/Http');
/**
 */
class GestionesController extends AppController{
    var $name = 'Gestiones';//inicializacion de variables
    public $components = array('RequestHandler');
    public $uses = array('Gestion');
    //funcion de inicio


    public function index() {
        $datas = $this->Gestion->find('all',array('order'=>array('Gestion.descripcion')));
        $gestiones = array();
        foreach($datas as $data):
            $gestion = array();
            foreach ($data as $key => $val):                
                foreach ($val as $key => $value):
                    $gestion[$key] = $value;
                endforeach;                
            endforeach;
            array_push($gestiones, $gestion);
        endforeach;
        $this->set(array(
            'gestiones' => $gestiones,
            '_serialize' => array('gestiones')
        ));       
    }

    public function view($id){
        $estudiante = $this->Estudiante->findById($id);
        $this->set(array(
            'estudiante' => $estudiante,
            '_serialize' => array('estudiante')
        ));
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