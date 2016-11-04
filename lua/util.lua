local _M = {}

function has_value(tbl, value)
  for i, v in pairs(tbl) do
    if v == value then return true end
  end
  return false
end

function _M.shorten(long_url)
  math.randomseed(os.time() + math.random(0, 100000))
  local s = ""
  local cz= {"a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "v", 
             "m", "n", "o", "p", "q", "r", "s", "t", "w", "x", "y", "z" }
  for _ = 1, 6, 1 do
    local index = math.random(1, #cz) 
    s = s .. cz[index] 
    end
  return s
end

-- escape postgresql string
function _M.pg_escape(str)
  return "'" .. string.gsub(str, "'", "''") .. "'"
end

-- get domain list
function _M.domain_list()
  local tlds = {}
  local domains = [[.ac.ad.ae.aero.af.ag.ai.al.am.an.ao.aq.ar.arpa.as.asia.at.au
    .aw.ax.az.ba.bb.bd.be.bf.bg.bh.bi.biz.bj.bm.bn.bo.br.bs.bt.bv.bw.by.bz.ca
    .cat.cc.cd.cf.cg.ch.ci.ck.cl.cm.cn.co.com.coop.cr.cs.cu.cv.cx.cy.cz.dd.de
    .dj.dk.dm.do.dz.ec.edu.ee.eg.eh.er.es.et.eu.fi.firm.fj.fk.fm.fo.fr.fx.ga
    .gb.gd.ge.gf.gh.gi.gl.gm.gn.gov.gp.gq.gr.gs.gt.gu.gw.gy.hk.hm.hn.hr.ht.hu
    .id.ie.il.im.in.info.int.io.iq.ir.is.it.je.jm.jo.jobs.jp.ke.kg.kh.ki.km.kn
    .kp.kr.kw.ky.kz.la.lb.lc.li.lk.lr.ls.lt.lu.lv.ly.ma.mc.md.me.mg.mh.mil.mk
    .ml.mm.mn.mo.mobi.mp.mq.mr.ms.mt.mu.museum.mv.mw.mx.my.mz.na.name.nato.nc
    .ne.net.nf.ng.ni.nl.no.nom.np.nr.nt.nu.nz.om.org.pa.pe.pf.pg.ph.pk.pl.pm
    .pn.post.pr.pro.ps.pt.pw.py.qa.re.ro.ru.rw.sa.sb.sc.sd.se.sg.sh.si.sj.sk
    .sl.sm.sn.so.sr.ss.st.store.su.sv.sy.sz.tc.td.tel.tf.tg.th.tj.tk.tl.tm.tn
    .to.tp.tr.travel.tt.tv.tw.tz.ua.ug.uk.um.us.uy.va.vc.ve.vg.vi.vn.vu.web.wf
    .ws.xxx.ye.yt.yu.za.zm.zr.zw]]

  for tld in domains:gmatch('%w+') do 
    tlds[tld] = true 
  end
  return tlds
end

-- check if given string is a valid url
function _M.valid_url(str)
  local protocol_list = { 'https://', 'http://', 'ftp://' }
  local regex = '([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*)'
  local prot, subd, tld, colon, port, slash, path = str:match(regex)
  -- check if protocol is on the supported list
  if not has_value(protocol_list, prot) then return false
  -- check for valid tld
  if not has_value(_M.domain_list, tld) then return false
  -- check for valid port
  if port and  port + 0 > 65536 then return false
  -- success
  return true
end

return _M
