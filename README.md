**Retired, because the MPI has been retired.**

---

# Source for 3dsecure.io MPI Docs

## Dependencies

* [Ruby](https://www.ruby-lang.org/) for middleman
* [NPM](https://npmjs.org) and [Bower](http://bower.io) for JavaScript dependencies


### Installation

```bash
git clone https://github.com/3dsecure/mpi-docs.git

docker build -t mpi-api-docs .
```

## Development
```bash
docker run --rm -it -p 4567:4567 -v :/web mpi-api-docs
```
Browse to http://localhost:4567

## Deployment
Using CircleCi for automatically deploying to s3 bucket.
The deployment will start once a branch is merged onto master.
