#!/usr/bin/env bash
git tag -a ${npm_package_version} -m "version ${npm_package_version}"
git push origin ${npm_package_version}