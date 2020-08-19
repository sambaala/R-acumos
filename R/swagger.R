#    Copyright (c) 2020 Orange
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
#' Generate swagger json from protobuf file
make_swagger_json = function(componentDir) {
  wd<-getwd()
  setwd(componentDir)
  file.copy(from = system.file("swagger","Makefile", package = "acumos"), to = ".")
  if (system('make -q ') == 0L){
    setwd(wd)
    file.remove("Makefile")
    return(FALSE)
  }
  if (system('make ') != 0){
    setwd(wd)
    file.remove("Makefile")
    stop('Failed to run Makefile')
  }
  setwd(wd)
  return(TRUE)
}