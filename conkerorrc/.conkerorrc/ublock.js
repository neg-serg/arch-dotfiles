interactive(
    "ublock", "Open uBlock dashboard in a new buffer",
    function (I) {
        var ublock_branch;
        if ("@ublock0/content-policy;1" in Cc) {
            ublock_branch = "ublock0";
        } else if ("@ublock/content-policy;1" in Cc) {
            ublock_branch = "ublock";
        } else {
            throw interactive_error("uBlock not found");
        }
        load_url_in_new_buffer("chrome://"+ublock_branch+"/content/dashboard.html");
    }
);

// To open the dashboard, hit:
//
// M-x ublock
