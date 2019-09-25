# Packer scripts

A collection of packer templates to build VM images for use with various cloud
platforms.

### gcp-debian-very-simple-template.json

A very simple script that can serve as a tutorial to make a Debian Buster
image on GCP. The assumed requirements for this build are:

    * have access to the zone `us-central1-a`
    * have a project called `sample-gcp-debian`
    * account file is `/gcloud/sample-gcp-debian-default.json`

Feel free to adjust the template to match your GCP project and directory to
your GCP credentials.

Regarding the template, specifically it does the following:

* creates a new Debian VM + GCP disk on a GCP account
* creates a generic user called `gcp-user`
* uses ssh to connect to ensure the VM is healthy
* converts the contents of VM + disk into a GCP image
* deletes the VM and disk

Build the image like so:

```bash
packer build gcp_debian_template.json
```

If there were no errors, then that means that your image was created
successfully.

### gcp-ubuntu-var-template.json

A slightly more complex script that can serve as a tutorial to make an Ubuntu
18.04 LTS image.

Regarding the template, specifically it does the following:

* creates a new Ubuntu 18.04 LTS VM + GCP disk on a GCP account
* creates a generic user called `gcp-user`
* uses ssh to connect to ensure the VM is healthy
* runs a sample inline shell command
* runs a sample init.sh bash script which prints "Hello World"
* converts the contents of VM + disk into a GCP image
* deletes the VM and disk

The only assumed requirements for this build are:

    * account file is `/gcloud/sample-gcp-ubuntu-default.json`

Unlike the Debian example, this template contains variables that must be
passed in as parameters, so thus, it must be validated.

So before build, ensure that your GCP Cloud is setup to give you API access,
and that you are able to access the regions and zones you request:

```bash
packer validate -var region="us-central1" \
                -var source_image_family="ubuntu-1804-lts" \
                -var machine_type="n1-standard-1" \
                -var zone="us-central1-a" \
                -var project_id=$PROJECT_ID \
                gcp-ubuntu-var-template.json
```

If that worked, then build the image like so:

```bash
packer build -var region="us-central1" \
             -var source_image_family="ubuntu-1804-lts" \
             -var machine_type="n1-standard-1" \
             -var zone="us-central1-a" \
             -var project_id=$PROJECT_ID \
             gcp-ubuntu-var-template.json
```

If there were no errors, then that means that your image was created
successfully.

### gcp-ubuntu-var-generic-webserver.json

Similar to the above, except this actually builds a useful VM image of
Ubuntu 18.04 LTS by installing common webserver components like nginx
and docker and others.

The only assumed requirements for this build are:

    * account file is `/gcloud/sample-gcp-ubuntu-default.json`

So before build, ensure that your GCP Cloud is setup to give you API access,
and that you are able to access the regions and zones you request:

```bash
packer validate -var region="us-central1" \
                -var source_image_family="ubuntu-1804-lts" \
                -var machine_type="n1-standard-1" \
                -var zone="us-central1-a" \
                -var project_id=$PROJECT_ID \
                gcp-ubuntu-var-generic-webserver.json
```

If that worked, then build the image like so:

```bash
packer build -var region="us-central1" \
             -var source_image_family="ubuntu-1804-lts" \
             -var machine_type="n1-standard-1" \
             -var zone="us-central1-a" \
             -var project_id=$PROJECT_ID \
             gcp-ubuntu-var-generic-webserver.json
```

If there were no errors, then that means that your image was created
successfully.
