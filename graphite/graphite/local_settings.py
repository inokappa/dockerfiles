GRAPHITE_ROOT = '/usr/share/graphite'
#
CONF_DIR = '/etc/graphite-web'
STORAGE_DIR = '/var/lib/graphite-web'
CONTENT_DIR = '/usr/share/graphite/webapp/content'
#
WHISPER_DIR = '/var/lib/carbon/whisper/'
RRD_DIR = '/var/lib/carbon/rrd'
LOG_DIR = '/var/log/graphite-web/'
#
DATABASES = {
  'default': {
    'NAME': 'graphite',
    'ENGINE': 'django.db.backends.mysql',
    'USER': 'graphite',
    'PASSWORD': 'passw0rd',
    'HOST': 'localhost',
    'PORT': '3306',
  }
}
