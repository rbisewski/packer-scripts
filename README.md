# Packer scripts

A collection of packer templates to build VM images for use with various cloud
platforms.

### gcp-debian-very-simple-template.json

A very simple script that can serve as a tutorial to make a Debian Buster
image. The assumed requirements for this build are:

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

Running the above command results in the following output:

```
googlecompute output will be in this color.

==> googlecompute: Checking image does not exist...
==> googlecompute: Creating temporary SSH key for instance...
==> googlecompute: Using image: debian-10-buster-v20190916
==> googlecompute: Creating instance...
    googlecompute: Loading zone: us-central1-a
    googlecompute: Loading machine type: n1-standard-1
    googlecompute: Requesting instance creation...
    googlecompute: Waiting for creation operation to complete...
    googlecompute: Instance has been created!
==> googlecompute: Waiting for the instance to become running...
    googlecompute: IP: 35.238.0.0
==> googlecompute: Using ssh communicator to connect: 35.238.0.0
==> googlecompute: Waiting for SSH to become available...
==> googlecompute: Connected to SSH!
==> googlecompute: Deleting instance...
    googlecompute: Instance has been deleted!
==> googlecompute: Creating image...
==> googlecompute: Deleting disk...
    googlecompute: Disk has been deleted!
Build 'googlecompute' finished.

==> Builds finished. The artifacts of successful builds are:
--> googlecompute: A disk image was created: packer-1790197130
```

If there were no errors, then that means that your image was created
successfully.
