Introduction
============


The purpose of factory_boy is to provide a default way of getting a new instance,
while still being able to override some fields on a per-call basis.


Basic usage
-----------


Declaring a factory is quite simple:

- Subclass ``factory.Factory`` (or a more suitable subclass)
- Set a ``FACTORY_FOR`` attribute pointing to the target class
- Add defaults for keyword args to pass to the associated class' ``__init__`` method


.. code-block:: python

    import factory
    from . import base

    class UserFactory(factory.Factory):
        FACTORY_FOR = base.User

        firstname = "John"
        lastname = "Doe"

You may now get ``base.User`` instances trivially:

.. code-block:: pycon

    >>> john = UserFactory()
    <User: John Doe>
    >>> jack = UserFactory(firstname="Jack")
    <User: Jack Doe>


A given class may be associated to many :class:`~factory.Factory` subclasses:

.. code-block:: python

    class EnglishUserFactory(factory.Factory):
        FACTORY_FOR = base.User

        firstname = "John"
        lastname = "Doe"
        lang = 'en'


    class FrenchUserFactory(factory.Factory):
        FACTORY_FOR = base.User

        firstname = "Jean"
        lastname = "Dupont"
        lang = 'fr'


.. code-block:: pycon

    >>> EnglishUserFactory()
    <User: John Doe (en)>
    >>> FrenchUserFactory()
    <User: Jean Dupont (fr)>


Subclassing
-----------


Once a "base" factory has been defined for a given class,
alternate versions can be easily defined through subclassing.

The subclassed :class:`~factory.Factory` will inherit all declarations from its parent,
and update them with its own declarations:

.. code-block:: python

    class UserFactory(factory.Factory):
        FACTORY_FOR = base.User

        firstname = "John"
        lastname = "Doe"
        group = 'users'

    class AdminFactory(UserFactory):
        admin = True
        group = 'admins'

.. code-block:: pycon

    >>> user = UserFactory()
    >>> user
    <User: John Doe>
    >>> user.group
    'users'
    
    >>> admin = AdminFactory()
    >>> admin
    <User: John Doe (admin)>
    >>> admin.group  # The AdminFactory field has overridden the base field
    'admins'


Any argument of all factories in the chain can easily be overridden:

.. code-block:: pycon

    >>> super_admin = AdminFactory(group='superadmins', lastname="Lennon")
    >>> super_admin
    <User: John Lennon (admin)>
    >>> super_admin.group  # Overridden at call time
    'superadmins'
