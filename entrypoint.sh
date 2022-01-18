#!/bin/bash -x

python3 -m venv /app/venv

if [[ -n "$REPOSITORY_URL" ]]
then
    echo "[global]" > /app/venv/pip.conf
    echo "index = $REPOSITORY_URL/" >> /app/venv/pip.conf
    echo "index-url = $REPOSITORY_URL/simple" >> /app/venv/pip.conf
    echo "trusted-host = $REPOSITORY_HOST" >> /app/venv/pip.conf
fi

cd /app
source /app/venv/bin/activate
python -m pip install --upgrade pip 
pip install wheel 


if [[ -n "$REQUIREMENTS_PACKAGES" ]]
then
    pip install $REQUIREMENTS_PACKAGES
fi

if [[ -n "$PACKAGE_VERSION" ]]
then
    pip install $PACKAGE_NAME==$PACKAGE_VERSION
else
    pip install $PACKAGE_NAME
fi
if [[ -n "$STARTUP_COMMAND" ]]
then
    $STARTUP_COMMAND
else
     ${PACKAGE_NAME//-/_}
fi
