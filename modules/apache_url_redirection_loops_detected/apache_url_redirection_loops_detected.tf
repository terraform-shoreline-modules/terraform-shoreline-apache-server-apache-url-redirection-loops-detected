resource "shoreline_notebook" "apache_url_redirection_loops_detected" {
  name       = "apache_url_redirection_loops_detected"
  data       = file("${path.module}/data/apache_url_redirection_loops_detected.json")
  depends_on = [shoreline_action.invoke_apache_redirect_correction]
}

resource "shoreline_file" "apache_redirect_correction" {
  name             = "apache_redirect_correction"
  input_file       = "${path.module}/data/apache_redirect_correction.sh"
  md5              = filemd5("${path.module}/data/apache_redirect_correction.sh")
  description      = "Implement 301 redirects instead of 302 redirects for permanent URL redirections to prevent loops."
  destination_path = "/agent/scripts/apache_redirect_correction.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_redirect_correction" {
  name        = "invoke_apache_redirect_correction"
  description = "Implement 301 redirects instead of 302 redirects for permanent URL redirections to prevent loops."
  command     = "`chmod +x /agent/scripts/apache_redirect_correction.sh && /agent/scripts/apache_redirect_correction.sh`"
  params      = ["PATH_TO_APACHE_CONFIG_FILE","PATH_TO_APACHE_DIRECTORY"]
  file_deps   = ["apache_redirect_correction"]
  enabled     = true
  depends_on  = [shoreline_file.apache_redirect_correction]
}

