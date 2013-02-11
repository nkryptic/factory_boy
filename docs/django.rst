Using factory_boy with Django
=============================


The first versions of factory_boy were designed specifically for Django,
but the library has now evolved to be framework-independant.

Most features should thus feel quite familiar to Django users.


The ``DjangoModelFactory`` subclass
-----------------------------------

All factories for a Django :class:`~django.db.models.Model` should use the
:class:`factory.DjangoModelFactory` base class.


This class provides the following features:

* :func:`~factory.Factory.create()` uses ``Model.objects.create()``
* :func:`~factory._setup_next_sequence()` selects the next unused primary key value
* :func:`~factory.RelatedFactory()` attributes will ``save()`` the base object after all related objects have been created

More features may be added later.
