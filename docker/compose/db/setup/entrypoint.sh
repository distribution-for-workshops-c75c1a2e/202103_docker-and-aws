#!/bin/bash -x
if ! (psql -l | grep ${DJANGO_PJ}); then
  createdb ${DJANGO_PJ}
fi
