# Wait-for-OpenMRS Github Action

This action waits for both the FHIR and REST endpoints of an OpenMRS instance to be available.
## Inputs

## `target-url`
Where OpenMRS is running, (e.g.) `http://isanteplus:8080/openmrs`

**Required** 
## `interval`
The interval between checking OpenMRS status, in seconds.

**Required** 
## `timeout`
The amount of time to try to connect before timing out, in seconds. 
**Required** 
## Example usage

```yml
uses: I-TECH-UW/wait-for-openmrs-action@v0.3.0
with:
  target-url: http://localhost:8080/openmrs
  timeout: 1000
  interval: 10
```
