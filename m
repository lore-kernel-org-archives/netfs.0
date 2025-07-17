Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE125771;
	Thu, 17 Jul 2025 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714341; cv=none; b=lNWb5Fy2j9tsNntRCnOLxx/9E/sJ5rUk03ZRFmQnkKIIUExtd+5OFAdfJdXwE3wDBSHqrpGPgHS3f80hyK5vkjE8lfsKIywYPlikp95Gij8+BDaLIZSjPmW3QJR2ZHvyuDdOoRTxaiAl1llgoOlBsYKD+/drmNuF9K2LP4NjDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714341; c=relaxed/simple;
	bh=9xZryO4rFVnSGnDvYSmx+6RTpRmgc4J9MPSC/kaqtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glofFNgruI1pFfF+N4W/Pb+K0/ETy60WfdQ3Fbdi9UGiBFJzCRMTKlNvRCn4XgWLbxRtb5bcGD2hxPDktLLHx+D3DNtRBtuNwE1qL1jgnUa95fRjO27A1RcwoXIDxygot/REaOyWP/FlkI8B6oL6eEVh2GO9e9A2DHHPSscdHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jz6XkYHH; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jz6XkYHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EI
	JgRbo2yBEeYOe56FQ8t29uLldSsA6Cw8nKiYtCDc8=; b=jz6XkYHHjOmUNGKAG8
	7zHJBqjQXWUhQMLTDbg8FNOvmse7PPf0qd3RKFzMwx+JQAzX7qb7lfhMl1oceFhG
	mZ7e/kTlAWcimrvizDTPt+1IpmD3mXC2jrhIei67mlLI9wrFG/fO1X7lbE1DqhuP
	M5O7aAVyT0SiYT1bn6IUAqBD0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL_QZTHhoBW1MAQ--.5971S2;
	Thu, 17 Jul 2025 09:04:39 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: nzzhao.sigma@gmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dwmw2@infradead.org,
	jack@suse.cz,
	jaegeuk@kernel.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netfs@lists.linux.dev,
	nico@fluxnic.net,
	ntfs3@lists.linux.dev,
	pc@manguebit.org,
	phillip@squashfs.org.uk,
	richard@nod.at,
	sfrench@samba.org,
	willy@infradead.org,
	xiang@kernel.org
Subject: Re: [f2fs-dev] Compressed files & the page cache
Date: Thu, 17 Jul 2025 09:04:14 +0800
Message-ID: <20250717010414.1595-1-nzzhao@126.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
References: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL_QZTHhoBW1MAQ--.5971S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykZr1DGr4rXrWxurWxJFb_yoW5XFWkpF
	W5KF1rKr4kXr4xAw47Aa12gFyF93s5JF47J34fKFWqy3W5J3sa9r1Dtas0vFWDGr93Xa1q
	vr4q934093s0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpwZcUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiZBKNz2h4PiLMHQAAsp

Dear Mr.Matthew and other fs developers:
I'm very sorry.My gmail maybe be blocked for reasons I don't know.I have to change
my email domain.
> So, my proposal is that filesystems tell the page cache that their minimu=
m
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.
Excuse me,but could you please clarify the meaning of "compression block si=
ze"?
If you mean the minimum buffer window size that a filesystem requires
to perform one whole compress write/decompress read io(also we can
call it the granularity),which,in f2fs context we can interpret as the
cluster size.Then that means for compress files,we could not fallback
to 0 order folio in memory pressure case when setting folio's minmium
order to "compression block size"?

If that is the case,then when f2fs' cluster size was configured,the
minium order was determined(and may beyond 64KiB.Depending on how we
set the cluster size).If the cluster size was set to a large number,we
will encounter much more risk when in memory pressure case.

Well,as for the 64Kib minimum granularity,because Android now switchs
page size to 16Kib so for current f2fs compress implementation the
minimum possible granularity indeed just exactly equals 64Kib.But I do
hold a opinion that may not be a very good point for f2fs. Because
just as I know,there are lots of small random write on Android.So
instead of having a minimum granularity in 64Kib,I appreciate future
f2fs's compression's implementation should support smaller cluster
size for compression. As far as I know,storage engineers from vivo is
experimenting a dynamic cluster compression implementation.It can
adjust the cluster size within a file adaptively.(Maybe larger in some
part and smaller in other part)
They didn't publish the code now.But this design maybe more suitable
for cooperating with folios for its vary-order feature.

>  It means we don't attempt to track dirtiness at a sub-folio granularity
>
> (there's no point, we have to write back the entire compressed bock
> at once).
That DO has point for f2fs.Because we cannot control the order of
folio that readahead gave us if we don't set maximum order.A large folio can cross 
multi clusters in f2fs as I have mentioned.
Since f2fs has no buffered head or a concept of subpage as we have discussed previously,
It must rely on iomap_folio_state or a similar per folio struct to distinguish which
cluster range of this folio is dirty.
And it must distinguish a partialy dirted cluster to avoid compress write.
Besides,l do think larger folio can cross multi compressed extent in
btrfs too if I didn't misunderstand.May I ask how do btrfs deal with
the possible write amplification?

