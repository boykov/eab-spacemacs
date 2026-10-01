(when (featurep 'native-compile)
  (startup-redirect-eln-cache (concat "eln-cache-" (daemonp) "/")))