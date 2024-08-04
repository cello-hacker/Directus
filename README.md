# docker-directus

An Instant App & API for your SQL Database in Docker.

Based on https://hub.docker.com/r/directus/directus .

```
cd docker/compose
```

Run either `./up-with-mariadb.sh` or `./up-with-postgres.sh`.

Next, open http://localhost:8055/ with username `admin@admin.com` and password `admin`.

See also:

  * https://directus.io/
  * https://hub.docker.com/r/wrzlbrmft/directus/tags

## Kubernetes (GKE)

```
gcloud compute disks create directus \
--size=10G \
--type=pd-standard \
--zone=us-east4-a
```

```
helm install --set staticPersistentVolume=true --set host=<host> directus docker/helm/directus
```

## License

The content of this repository is distributed under the terms of the
[GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.en.html).
