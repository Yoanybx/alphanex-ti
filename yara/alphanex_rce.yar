rule AlphaNex_RCE_Loader
{
    meta:
        description = "Detecta el RCE del repo AlphaNex"
        author = "gepsygainza"
        date = "2026-09-28"
        hash = "bcd3d24f96fd0da1015869774a56c3710136c76bbab108e163f1cef38f913cce"
        tlp = "white"

    strings:
        $domain = "zoo-eta1.vercel.app" ascii wide
        $path = "parser5" ascii wide
        $token = "258365314" ascii wide
        $newfunc = "new Function" ascii wide
        $createreq = "createRequire" ascii wide
        $cmd1 = "npm install axios" ascii wide
        $cmd2 = "wcl3ce" ascii wide
        $execsync = "execSync" ascii wide
        $obf1 = "var I=[\x27WQ" ascii
        $obf2 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=" ascii

    condition:
        2 of them
}
