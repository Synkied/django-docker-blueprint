from .base import *  # noqa

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': '{|DB_NAME|}',
        'USER': '{|DB_NAME|}',
        'PASSWORD': '',
        'HOST': 'database',
        'PORT': '5432',
    }
}
