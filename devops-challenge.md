# Challenge Statement

This challenge is about using Docker to encapsulatea tool called [Mkdocs](http://www.mkdocs.org/) to produce and serve a website because we don’t want to install Mkdocs locally.

The idea is to:

- Create a Git project that builds a Docker image.
- This Docker image, when run, should accept a directory from your local filesystem as input and use Mkdocs to produce and serve a website.
- This local directory is the root of a valid Mkdocs project with which this tool can create the site.

## Details

## Producing the website

When you execute this from the command line:

```bash
$docker run <arguments> <the-docker-image-name> produce
```

This should:

1. Pass as an argument and read the local directory that contains the Mkdocs project.
2. Internally use Mkdocs.
3. Write out to the stdout a `.tar.gz` file. This `.tar.gz` file should include the static website:
a. the index.html in its root,
b. and all the resources produced by mkdocs.
4. Then Exit.

## Running the website

When you execute this from the command line:

```bash
$docker run -p 8000:8000 <arguments> <the-docker-image-name> serve
```

This should read the `.tar.gz` file produced from the `produce` command from stdin and then use Mkdocs internally to serve it on port `8000`, so when we browse to `http://localhost:8000` we’ll see the website.

Please provide a wrapper script called `mkdockerize.sh` at the root of your Git project that runs both `produce` and `serve` options of the Docker container, taking care of passing arguments from the command line into the container. Also include either a `gitlab-ci.yml` or `Jenkinsfile` that contains a build and a test stage.

Lastly, please include a `README.md` file that documents your project as best as you can so we know what it does and how to run it.
