{{flutter_js}}
{{flutter_build_config}}

const serviceWorkerVersion = '{{flutter_service_worker_version}}';

let baseUri = document.baseURI;
if (baseUri.endsWith('/')) {
    baseUri = baseUri.slice(0, -1);
}

_flutter.loader.load({
    serviceWorkerSettings: {
        serviceWorkerVersion: serviceWorkerVersion,
        serviceWorkerUrl: `${baseUri}/flutter_service_worker.js?v=${serviceWorkerVersion}`,
    },
    onEntrypointLoaded: function(engineInitializer) {
        engineInitializer.initializeEngine().then(function(appRunner) {
            appRunner.runApp();
        });
    },
});