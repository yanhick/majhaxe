::foreach targets::
#::name::
-main Main
::foreach libs::-lib ::__current__::::end::
-cp ::path::
::foreach options::::__current__::::end::
::output::

--next
::end::
