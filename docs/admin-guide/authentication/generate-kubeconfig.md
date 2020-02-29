# Generating Kubeconfigs

### Install kubectl

```shell
$ brew install kubernetes-cli
```

### Install kubelogin

```shell
$ brew tap int128/kubelogin
$ brew install kubelogin
```

### Update your ~/.kube/config file

A single-sign on enabled kubeconfig can be generated by the administrator using:

```shell
platform-cli kubeconfig sso
```

or alternatively create one by updating the values below:
```yaml
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server:
  name: cluster
contexts:
- context:
    cluster: cluster
    user: sso
  name: cluster
current-context: cluster
kind: Config
preferences: {}
users:
- name: cluster
  user:
    auth-provider:
      config:
        client-id: <...>
        client-secret: <...>
        extra-scopes: offline_access openid profile email groups
        idp-certificate-authority-data: <...>
        idp-issuer-url: https://dex.{domain}
      name: oidc
```

### Get access token:

```shell
$ kubelogin get-token --oidc-issuer-url=https://dex.127.0.0.1.nip.io \
                    --oidc-client-id=kubernetes \
                    --oidc-client-secret=ZXhhbXBsZS1hcHAtc2VjcmV0 \
                    --oidc-extra-scope=email,groups,offline_access,profile,openid \
                    --insecure-skip-tls-verify
```

### Set access token in ~/.kube/config

```yaml
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server:
  name: cluster
contexts:
- context:
    cluster: cluster
    user: sso
  name: cluster
current-context: cluster
kind: Config
preferences: {}
users:
- name: cluster
  user:
    auth-provider:
      config:
        client-id: <...>
        client-secret: <...>
        extra-scopes: offline_access openid profile email groups
        idp-certificate-authority-data: <...>
        idp-issuer-url: https://dex.{domain}
        id-token: <...>
        access-token: <...>
        refresh-token: <...>
      name: oidc
```
