#include "clutterperl.h"

MODULE = Clutter::Texture::Cairo PACKAGE = Clutter::Texture::Cairo PREFIX = clutter_cairo_

BOOT:
        gperl_set_isa ("Clutter::Cairo::Context", "Cairo::Context");

ClutterActor *
clutter_cairo_new (class, gint width, gint height)
    C_ARGS:
        width, height

SV *
clutter_cairo_create_context (ClutterCairo *texture)
    PREINIT:
        cairo_t *cr;
    CODE:
        /* We own cr. */
        cr = clutter_cairo_create (texture);
        RETVAL = newSV (0);
        sv_setref_pv (RETVAL, "Clutter::Cairo::Context", (void *) cr);
    OUTPUT:
        RETVAL