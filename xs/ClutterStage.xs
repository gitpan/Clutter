/* Clutter.
 *
 * Perl bindings for the OpenGL based 'interactive canvas' library.
 *
 * Clutter Authored By Matthew Allum  <mallum@openedhand.com>
 * Perl bindings by Emmanuele Bassi  <ebassi@openedhand.com>
 * 
 * Copyright (C) 2006 OpenedHand
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "clutterperl.h"

MODULE = Clutter::Stage		PACKAGE = Clutter::Stage	PREFIX = clutter_stage_

ClutterActor *
clutter_stage_get_default (class)
    C_ARGS:
        /* void */

void
clutter_stage_set_color (ClutterStage *stage, ClutterColor *color)

ClutterColor_copy *
clutter_stage_get_color (ClutterStage *stage)
    PREINIT:
        ClutterColor color;
    CODE:
        clutter_stage_get_color (stage, &color);
	RETVAL = &color;
    OUTPUT:
        RETVAL

ClutterActor *
clutter_stage_get_actor_at_pos (ClutterStage *stage, gint x, gint y)

GdkPixbuf_noinc *
clutter_stage_snapshot (stage, x, y, width, height)
        ClutterStage *stage
        gint x
        gint y
        gint width
        gint height

void
clutter_stage_fullscreen (ClutterStage *stage)

void
clutter_stage_unfullscreen (ClutterStage *stage)

void
clutter_stage_show_cursor (ClutterStage *stage)

void
clutter_stage_hide_cursor (ClutterStage *stage)

void
clutter_stage_set_title (ClutterStage *stage, const gchar_ornull *title)

const gchar *
clutter_stage_get_title (ClutterStage *stage)

void
clutter_stage_event (ClutterStage *stage, ClutterEvent *event)

=for apidoc
=for signature (fovy, aspect, z_near, z_far) = $stage->get_perspective
=cut
void
clutter_stage_get_perspective (ClutterStage *stage)
    PREINIT:
        ClutterPerspective persp;
    PPCODE:
        clutter_stage_get_perspectivex (stage, &persp);
        EXTEND (SP, 4);
        PUSHs (sv_2mortal (newSVnv (CLUTTER_FIXED_TO_DOUBLE (persp.fovy))));
        PUSHs (sv_2mortal (newSVnv (CLUTTER_FIXED_TO_DOUBLE (persp.aspect))));
        PUSHs (sv_2mortal (newSVnv (CLUTTER_FIXED_TO_DOUBLE (persp.z_near))));
        PUSHs (sv_2mortal (newSVnv (CLUTTER_FIXED_TO_DOUBLE (persp.z_far))));

void
clutter_stage_set_perspective (stage, fovy, aspect, z_near, z_far)
        ClutterStage *stage
        double fovy
        double aspect
        double z_near
        double z_far
    PREINIT:
        ClutterPerspective persp;
    CODE:
        persp.fovy = CLUTTER_FLOAT_TO_FIXED (fovy);
        persp.aspect = CLUTTER_FLOAT_TO_FIXED (aspect);
        persp.z_near = CLUTTER_FLOAT_TO_FIXED (z_near);
        persp.z_far = CLUTTER_FLOAT_TO_FIXED (z_far);
        clutter_stage_set_perspectivex (stage, &persp);

void
clutter_stage_set_user_resizable (ClutterStage *stage, gboolean resizable)

gboolean
clutter_stage_get_user_resizable (ClutterStage *stage)
