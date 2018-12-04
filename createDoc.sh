#!/bin/bash
jazzy --config ./VISPER/.jazzy.yaml
mkdir -p ./docs/VISPER/docs/img
cp -R ./docs/img/* ./docs/VISPER/docs/img/
jazzy --config ./VISPER-Core/.jazzy.yaml
jazzy --config ./VISPER-Entity/.jazzy.yaml
jazzy --config ./VISPER-Objc/.jazzy.yaml
jazzy --config ./VISPER-Presenter/.jazzy.yaml
jazzy --config ./VISPER-Presenter/.jazzy-objc.yaml
jazzy --config ./VISPER-Reactive/.jazzy.yaml
jazzy --config ./VISPER-Redux/.jazzy.yaml
jazzy --config ./VISPER-Sourcery/.jazzy.yaml
jazzy --config ./VISPER-Swift/.jazzy.yaml
jazzy --config ./VISPER-UIViewController/.jazzy.yaml
jazzy --config ./VISPER-UIViewController/.jazzy-objc.yaml
jazzy --config ./VISPER-Wireframe/.jazzy.yaml


