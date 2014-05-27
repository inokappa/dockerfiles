define(['settings'],
function (Settings) {

  return new Settings({

    graphiteUrl: "http://172.17.0.2",

    default_route: '/dashboard/file/default.json',

    timezoneOffset: null,

    grafana_index: "grafana-dash",

    unsaved_changes_warning: true,

    panel_names: [
      'text',
      'graphite'
    ]
  });
});
