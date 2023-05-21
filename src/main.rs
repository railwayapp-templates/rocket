#[macro_use]
extern crate rocket;
use std::env;

#[get("/")]
fn index() -> &'static str {
    "Hello, from Rocket!"
}

#[launch]
fn rocket() -> _ {
    env::set_var("ROCKET_ADDRESS", "0.0.0.0");
    if let Ok(port) = env::var("PORT") {
        env::set_var("ROCKET_PORT", port);
    }

    rocket::build().mount("/", routes![index])
}
