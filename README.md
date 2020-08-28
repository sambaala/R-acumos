# Acumos R Interface

## Install

Under Debian/Ubuntu, install `devtools` and `acumos` dependencies first:

    apt install -y libssl-dev libcurl4-openssl-dev make libgit2-dev zlib1g-dev libssh2-1-dev libxml2-dev git-core protobuf-compiler libprotoc-dev libprotobuf-dev
    
In R, install `devtools`:

    install.packages("devtools")

Install this dev version of `acumos`:

    devtools::install_github("sambaala/R-acumos")

## Usage

### Create a component

To create a deployment component, use `acumos::compose()` with the functions to expose. If type specs are not defined, they default to `c(x="character")`.

The component consists of a bundle `component.amc` which is a ZIP file with `meta.json` defining the component and its metadata, `component.bin` the binary payload and `component.proto` with the protobuf specs and `component.swagger.yaml` with the Swagger API 
definition.

Please consult R documentation page for details, i.e., use `?compose` in R.

Example:
    
    install.packages("randomForest")
    library(randomForest)
    library(acumos)
    compose(predict=function(..., inputs=lapply(iris[-5], class)) as.character(predict(rf, as.data.frame(list(...)))),
        aux = list(rf = randomForest(Species ~ ., data=iris)),
        name="Random Forest",
        file="component.amc"
        )

### Deploy a component

To run the component you can create a `runtime.json` file with at least `{"input_port":8100}` or similar to define which port the component should listen to. If there are output components there should also be a `"output_url"` entry to specify where to send the result to. It can be either a single entry or a list if the results are to be sent to multiple components. Example:

    {"input_port":8100, "output_url":"http://127.0.0.1:8101/predict"}

With the component bundle `component.amc` plus `runtime.json` in place the component can be run using

    R -e 'acumos:::run()'

The `run()` function can be configured to set the component directory and/or location of the component bundle. If you don't want to create a file, the `runtime` parameter also accepts the runtime structure, so you can also use

    R -e 'acumos:::run(runtime=list(input_port=8100, data_response=TRUE))'

See also `?run` in R.