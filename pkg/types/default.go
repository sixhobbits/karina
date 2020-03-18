package types

func DefaultPlatformConfig() PlatformConfig {
	config := PlatformConfig{
		CertManager: CertManager{
			Version: "v1.12.0",
		},
		Ldap: &Ldap{
			GroupObjectClass: "group",
			GroupNameAttr:    "name",
		},
		Kubernetes: Kubernetes{
			APIServerExtraArgs:  map[string]string{},
			ControllerExtraArgs: map[string]string{},
			SchedulerExtraArgs:  map[string]string{},
			KubeletExtraArgs:    map[string]string{},
			EtcdExtraArgs:       map[string]string{},
		},
	}
	return config
}
