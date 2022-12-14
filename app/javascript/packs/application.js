import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"

import "stylesheets/application";

import "@fortawesome/fontawesome-free/css/all.css";

import "trix"
import "@rails/actiontext"