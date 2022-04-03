# Sample Bazel/ScalaTest/Bazel/Flyway project
## Prerequisites:
- Scala version - 2.13.8
- Bazel version - 4.2.0
- Docker installed

## Useful links:
- Scala rules for Bazel: https://github.com/bazelbuild/rules_scala
- Generate bazel dependencies transitively for maven artifacts, with scala support: https://github.com/johnynek/bazel-deps

## Environment preparation
- **Mac OS / Linux:** In case new dependencies need to be added, add dependencies to dependencies.yaml file and run update_dependencies.sh script.
- Windows: Use https://github.com/johnynek/bazel-deps for help.

## Start postgres and pg_admin
In the project root
> cd db/postgres
> 
> docker-compose up

**To acess pg_admin go to http://localhost:5050**
All credentials in docker-compose.yaml.

### You're set to run tests!

