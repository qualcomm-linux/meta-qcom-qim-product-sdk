python __anonymous() {
    import os
    import bb

    # Get GST version
    pv = d.getVar("PV")
    pn = d.getVar("PN")

    CONFDIR = d.getVar("CONFDIR")
    recipes_dir = os.path.join(CONFDIR, "../recipes-gst/gstreamer/")
    parts = pv.split('.')

    # Full version
    patterns = [pn + "_" + pv + ".inc"]

    if len(parts) >= 2:
        # Major.Minor% version
        patterns.append(pn + "_" + parts[0] + "." + parts[1] + "%.inc")

    if len(parts) >= 1:
        # Major% version
        patterns.append(pn + "_" + parts[0] + "%.inc")

    # Wildcard
    patterns.append(pn + "_%.inc")

    for pattern in patterns:
        inc_file = os.path.join(recipes_dir, pattern)

        if os.path.isfile(inc_file):
            # include .inc file
            bb.parse.handle(inc_file, d, True)
            break
}
