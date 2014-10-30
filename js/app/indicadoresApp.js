var indicadoresApp = angular.module('indicadoresApp', ['ngRoute',
						       "highcharts-ng",
						       'ui.grid',
						       'ui.grid.selection', 
						       'ui.grid.expandable',
						       'ui.grid.resizeColumns',
						       'indicadoresAppServices',
						       'graficasControllers']);

var indicadoresAppServices = angular.module('indicadoresAppServices', ['ngResource']);
var graficasController = angular.module('graficasControllers',[]);

indicadoresAppServices.factory('GestionesFactory', function ($resource) {
    return $resource('/index.php/gestiones.json', {}, {
        query: { method: 'GET', isArray: false},
        create: { method: 'POST' }
    })
});

indicadoresAppServices.factory('ReportesFactory', function ($resource) {
    return $resource('/index.php/reportes.json?reporte_id=:id', {}, {
        query: { method: 'GET', params: {id:'@id'}, isArray: false},
        create: { method: 'POST' }
    })
});

indicadoresAppServices.factory('ReporteFactory', function ($resource) {
    return $resource('/index.php/reportes/:id.json?gestion=:gestion', {}, {
        query: { method: 'GET', params: {id:'@id', gestion: '@gestion'}, isArray: false}
    })
});

indicadoresAppServices.factory('TableFactory', function ($resource) {
    return $resource('/index.php/tables/:id.json', {}, {
        query: { method: 'GET', params: {id:'@id'}, isArray: false}
    })
});


indicadoresApp.config(function($routeProvider) {
    $routeProvider
			// route for the home page
	.when('/', {
	    templateUrl : 'pages/main.html',
	    controller  : 'graficasController'
			})
        .when('/padron', {
            templateUrl : 'pages/padron.html',
            controller  : 'padronController'
        })

	.when('/recaudaciones', {
	    templateUrl : 'pages/recaudaciones.html',
	    controller  : 'recaudacionesController'
	})
	.when('/deudas', {
	    templateUrl : 'pages/deudas.html',
	    controller  : 'deudasController'
	});
});


graficasController.controller('graficasController', ['$scope','GestionesFactory','ReportesFactory','ReporteFactory','TableFactory','$location',function($scope, GestionesFactory, ReportesFactory, ReporteFactory, TableFactory, $location) {
    $scope.gestiones = null;
    $scope.reportes_padron = null;
    $scope.reportes_recaudacion = null;
    $scope.reportes_deuda = null;

    // Variable de Dashboard
    $scope.padron = null;
    $scope.recaudacion = null;
    $scope.deuda = null;
    // Variables de Graficas
    $scope.chartPadron = null;
    $scope.chartRecaudacion = null;
    $scope.chartDeuda = null;
    // Varible de tablas
    $scope.gridPadron = {
        enableFiltering: false
    };
    $scope.gridRecaudacion = {
        enableFiltering: false
    };
    $scope.gridDeuda = {
        enableFiltering: false
    };     
    
    // Funciones
    $scope.selectGestion = function(reportePadronId, reporteRecaudacionId, reporteDeudaId, gestionId){
	ReporteFactory.query({id: 4, gestion: gestionId},function(data){$scope.padron = data.datos});
        ReporteFactory.query({id: 6, gestion: gestionId},function(data){$scope.recaudacion = data.datos});
        ReporteFactory.query({id: 7, gestion: gestionId},function(data){$scope.deuda = data.datos});

	ReporteFactory.query({id: reportePadronId, gestion: gestionId},
			     function(data){$scope.chartPadron = data.datos;
					    if($scope.chartPadron.options.chart.type == 'map'){				     
						//console.log($scope.chartDeuda.series[0]);
						$scope.chartPadron.series[0].mapData = Highcharts.maps['municipio/altagracia'];
						//console.log(Highcharts.maps['municipio/altagracia']);
						$scope.chartPadron.series[0].joinBy = ['descripcio','hc-key'];
					    };
					   });
	ReporteFactory.query({id: reporteRecaudacionId, gestion: gestionId},
			     function(data){$scope.chartRecaudacion = data.datos;
					    if($scope.chartRecaudacion.options.chart.type == 'map'){				     
						//console.log($scope.chartDeuda.series[0]);
						$scope.chartRecaudacion.series[0].mapData = Highcharts.maps['municipio/altagracia'];
						//console.log(Highcharts.maps['municipio/altagracia']);
						$scope.chartRecaudacion.series[0].joinBy = ['descripcio','hc-key'];
					    };
					   });
        ReporteFactory.query({id: reporteDeudaId, gestion: gestionId},
			     function(data){$scope.chartDeuda = data.datos;
					    if($scope.chartDeuda.options.chart.type == 'map'){
				     
						//console.log($scope.chartDeuda.series[0]);
						$scope.chartDeuda.series[0].mapData = Highcharts.maps['municipio/altagracia'];
						//console.log(Highcharts.maps['municipio/altagracia']);
						$scope.chartDeuda.series[0].joinBy = ['descripcio','hc-key'];
					    };
					   });
    }

    $scope.selectReportePadron = function(reporteId, gestionId){
	ReporteFactory.query({id: reporteId, gestion: gestionId},
			     function(data){
				 $scope.chartPadron = data.datos;
				 if($scope.chartPadron.options.chart.type == 'map'){
				     
				     //console.log($scope.chartDeuda.series[0]);
				     $scope.chartPadron.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				     //console.log(Highcharts.maps['municipio/altagracia']);
				     $scope.chartPadron.series[0].joinBy = ['descripcio','hc-key'];
				 };
			     });
	TableFactory.query({id: reporteId}, function(data){$scope.gridPadron.data = data.datos});
    };


    $scope.selectReporteRecaudacion = function(reporteId, gestionId){
	ReporteFactory.query({id: reporteId, gestion: gestionId},
			     function(data){
				 $scope.chartRecaudacion = data.datos;
				 if($scope.chartRecaudacion.options.chart.type == 'map'){
				     
				     //console.log($scope.chartDeuda.series[0]);
				     $scope.chartRecaudacion.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				     //console.log(Highcharts.maps['municipio/altagracia']);
				     $scope.chartRecaudacion.series[0].joinBy = ['descripcio','hc-key'];
				 };
			     });
	TableFactory.query({id: reporteId}, function(data){$scope.gridRecaudacion.data = data.datos});
    };

    $scope.selectReporteDeuda = function(reporteId, gestionId){
	ReporteFactory.query({id: reporteId, gestion: gestionId},
			     function(data){
				 $scope.chartDeuda = null;
				 $scope.chartDeuda = data.datos;
				 if($scope.chartDeuda.options.chart.type == 'map'){
				     
				     //console.log($scope.chartDeuda.series[0]);
				     $scope.chartDeuda.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				     //console.log(Highcharts.maps['municipio/altagracia']);
				     $scope.chartDeuda.series[0].joinBy = ['descripcio','hc-key'];
				 };
			     }
			    );
	TableFactory.query({id: reporteId}, function(data){$scope.gridDeuda.data = data.datos});
    };

    // Combo Gestiones
    GestionesFactory.query(function(data){$scope.gestiones = data.gestiones;$scope.gestion = $scope.gestiones[9];});
    
    // Combos
    ReportesFactory.query({id: 1},function(data){$scope.reportes_padron = data.reportes; $scope.reporte_padron = $scope.reportes_padron[0];});
    ReportesFactory.query({id: 2},function(data){$scope.reportes_recaudacion = data.reportes; $scope.reporte_recaudacion = $scope.reportes_recaudacion[0];});
    ReportesFactory.query({id: 3},function(data){$scope.reportes_deuda = data.reportes; $scope.reporte_deuda = $scope.reportes_deuda[0];});
    // Dashboard
    ReporteFactory.query({id: 4, gestion: 2014},function(data){$scope.padron = data.datos});
    ReporteFactory.query({id: 6, gestion: 2014},function(data){$scope.recaudacion = data.datos});
    ReporteFactory.query({id: 7, gestion: 2014},function(data){$scope.deuda = data.datos});
    // Graficas

    ReporteFactory.query({id: 3, gestion: 2014},
			 function(data){
			     $scope.chartPadron = data.datos;
			     if($scope.chartPadron.options.chart.type == 'map'){
				 $scope.chartPadron.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				  //console.log(Highcharts.maps['municipio/altagracia']);
				 $scope.chartPadron.series[0].joinBy = ['descripcio','hc-key'];
				 };
			 });
    ReporteFactory.query({id: 13, gestion: 2014},
			 function(data){
			     $scope.chartRecaudacion = data.datos;
			     if($scope.chartRecaudacion.options.chart.type == 'map'){
				     
				     //console.log($scope.chartDeuda.series[0]);
				     $scope.chartRecaudacion.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				     //console.log(Highcharts.maps['municipio/altagracia']);
				     $scope.chartRecaudacion.series[0].joinBy = ['descripcio','hc-key'];
				 };
			 });
    ReporteFactory.query({id: 9, gestion: 2014},
			 function(data){
			     $scope.chartDeuda = data.datos;
			     if($scope.chartDeuda.options.chart.type == 'map'){
				     
				     //console.log($scope.chartDeuda.series[0]);
				     $scope.chartDeuda.series[0].mapData = Highcharts.maps['municipio/altagracia'];
				     //console.log(Highcharts.maps['municipio/altagracia']);
				     $scope.chartDeuda.series[0].joinBy = ['descripcio','hc-key'];
				 };
			 }
			);
    

    // Tables
    TableFactory.query({id: 3}, function(data){$scope.gridPadron.data = data.datos});
    TableFactory.query({id: 8}, function(data){$scope.gridRecaudacion.data = data.datos});
    TableFactory.query({id: 9}, function(data){$scope.gridDeuda.data = data.datos});

}]);
