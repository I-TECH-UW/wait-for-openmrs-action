# Wait-for-isanteplus Github Action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `target-url`

**Required** 

## `interval`

**Required** 
## `timeout`

**Required** 
## Example usage

uses: actions/action-wait-for-isanteplus@v1
with:
  target-url: http://localhost:8080/openmrs
  timeout: 1000
  interval: 10