locals {
  lz_config = yamldecode(file("../../lzconfig.yaml"))
  lifecyclerules = [
    {
      id      = "transition-noncurrentversion-to-glacier"
      enabled = true

      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "GLACIER"
        },
      ]
  }]
}