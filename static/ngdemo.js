angular.module("demoApp", ['ngRoute'])

    .factory('melonsService', function ($http) {
        return {
            getMelons: function () {
                return $http.get("melons.json").then(function (response) {
                    return response.data;   // .data = body of the response
                });
            }
        };
    })

    .config(function ($routeProvider) {
        $routeProvider

            .when('/', {
                templateUrl: 'search-form.html'
            })

            .when('/login', {
                templateUrl: 'login-form.html',
                controller: 'StockController'
            })

            .when('/melons', {
                templateUrl: 'melons.html',
                controller: 'MelonsController',
                resolve: {
                    melons: function (melonsService) {
                        return melonsService.getMelons();
                    }
                }
            });
    })

    .controller('StockController', function ($scope, $timeout) {

        $scope.stockPrice = Math.random() * 1000;

        $scope.buy = function(nshares) {
            $scope.message = nshares + " shares bought!";
            $timeout(function () {
                $scope.message = "";
            }, 1500);
        };
    })

        .controller('MelonsController', function ($scope, melons) {

        //$http.get("/melons.json").then(function (response) {
        //    $scope.melons = response.data;
        //});

        $scope.melons = melons;
    })
;