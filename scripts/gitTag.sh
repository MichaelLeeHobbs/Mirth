#!/usr/bin/env bash
git tag -a v${npm_package_version} -m "version ${npm_package_version}"
git push origin v${npm_package_version}