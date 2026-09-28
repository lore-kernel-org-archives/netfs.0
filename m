Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E4359A66
	for <netfs@lists.linux.dev>; Mon, 28 Sep 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565392; cv=pass; b=NkGg+WDGvAjGYUDoAVPQEZFN7O1QYD68EKsCHPeNKgk9UCj4vBLJutAehNVtgj4ys1WzEzDBhbNp7zRecn9LoUdBWsNUrFnzC412h6zsIvAzC0FBN7S15DdzeUe6KS1SOcAkhReHJoFKU5yN3XXo0KnUDJrrOX3nJEthRMFYeCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565392; c=relaxed/simple;
	bh=irNG+DoNMCWFLV1hw/t2FuuwOuA5DzeUKeYzGMNo+C4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O0YzW+sgJcPgPWGZfqYit22KjjEDGQVPb5L6zY4n2pBNgrJ5E9FwjepZjHT7fRMtGLta3B4Zf7PoB5tlYL9PHEIMMe0bREfVM15Dd9PFM95GMOiw8zgUhOCnfwu4VPdEXKvLc3N33oHGqzEiL9RAZ7LgzMbsBvfeJe9jMPz9yhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiSanyd9; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiSanyd9"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3ab8so1319361241.1
        for <netfs@lists.linux.dev>; Sun, 27 Sep 2026 20:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790565390; cv=none;
        d=google.com; s=arc-20260327;
        b=gHxFxHCGrRXI3BJJ0LBtGLEkltvt7dAKmkGWOsrCynBf9tMpcXAM1kvwdM9GZIKKNk
         XlU9y59n38rJJBU8YVLLn6O8/rEYvBH8xOjWsNHDN8PZg9SWI6e2WtDUED5JLBzHt2XD
         /uMpmPYuLCquLgM+8zGn0IVfeHVpj6JAxyzROutLfkOc4C3lvttbs42BDT5A7J12qUtv
         PERoNExajrtWENvBMYFE2li8gXhPIPUQfi6UwTw6rDXNnh1I+kLDaw358fZqdwlJoUss
         vYRrNbqhoyiydL6Esjhh54Hl3zrZANB4mtAfY7H1k9l6cwiSiiO5+IIe7iZrPXGNOnXs
         CLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SX5Ye7MtdrUJ2FauXGucUbRpX1moQo3Ho9RVhKOtv5M=;
        fh=8Dhqai7EjFm1DPjzi5UvQYw7eIiMiQoJWMtsHGPm210=;
        b=FbZcbn52u30TVOoCZC0XFARDNyMrbm97YAytLZ0TMTGNAqiplhW2TxzhJ0sl62uOz+
         pSH5bLXqNHB4oCAlbGl4cTHpiLa3hxAsJ68/+J3e80hMqCqdJJY1DX9koHP+JNuPH32v
         7Z/vadrHpwMQUqPMVN6+KXCVH4bqcN3XvzHtQqImrGj/Fw5XfzaSWTRlGccZaNtfa1LT
         ybjKVSnAwxvLSC+TO5Nwy2zrkcY+4Lhnrz603JfuniBlF/G7VMHb+sA1BEp3NAw1x3ys
         6qwrkaEOubvHhLSBP5pXH91mtB0rzxh7Mw28sCAn1DyF89G0VNiWJ7GfSVOCQ+v1FxQD
         2t4Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790565390; x=1791170190; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SX5Ye7MtdrUJ2FauXGucUbRpX1moQo3Ho9RVhKOtv5M=;
        b=DiSanyd9Uj8IHVcxlXizf3itfmHG2E+ZX1M4E/uBSOBfriDXM35gScLb/a/ADsNoCH
         AR3m0iip0D6FYVqC2YSFo1YTkmIIctd78rrqZOX5MLaBUP3KEWEb9ojL4KecU89FS8BA
         E+otjvy93vkvYnDrVdA4dCJL6CQackQzZcHUv1V6cOtBQRIYt3YhCvvmLPuSEh3pVsJk
         Ew3okY+y+y2EEDPqKoChVvBz/GuPtT6neHP1goWmC7H6qTT/IZeviDRtMX/zzzx0Fr/S
         npaLq0MfA1vrQ5zTRFWifW6WCiSxBSr0q8NjsJGJItSMEjVrvQj8JA4xucDRMVRisorq
         JXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790565390; x=1791170190;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SX5Ye7MtdrUJ2FauXGucUbRpX1moQo3Ho9RVhKOtv5M=;
        b=z+Rvmi5ebfpKM4EvMDmOk0Jx1xdgIaCUbCHG3ZhLVJ6qVA9NzUOfE7DEq0wYgZh7fv
         Csh3qOREmWwgZJKNKh9+1SQgijavmVFO5teNyTsu5go32OoR+i7hkeTmSRc3k4I9KqVi
         fWteBTOFC4bz1vLNXXlrOdpNc3yPpp24gg4tWxccbkJtjFb35eDGt7nBfwa8pae/awno
         lzhR6MO5tPp3dfeZdGdNDklkveGasf6G0gmISb5NciDJPtYpDhA6DN3pfT79N0V8DDgF
         6Svh/FCIr7jfJ91XdajS47rzZlZ93kadMDxpQfJ89SmS6ZhypvNE/n95AYVJ9jHWkOgQ
         FD1Q==
X-Gm-Message-State: AFq9FYLiXS5XYqg0NkwQPqfbhM/uYZhg78lpbQgb/tMSyO3lgVA/tP6q
	ID1DzNUVPi39bCGvTBk5teKAmuYtxj3OUkFoTGNP2M7bdWvb9LQ8VNpBpQVSCfPorlqwZkO+rEp
	uUHrB6lGj5Ub4wRGY01dsGncNGrUDCdM=
X-Gm-Gg: AYBFou3NQFoUOjxjQjRkaEwuP9be5m9xSt2s9ZT8LiXT/JZIFwghcyhUrBPZ2e83v4z
	AgTp3eLa7ZCEaNRB+y623FXER4hq7yqNEBCVoGB+IVhUzojiVuhqmJy+RIu34id0ezpvWFiKDtt
	4Rr8iJ8wzU61UsEyzEPU9/h+yiJu+eklXQqTpnZ2rxum5W0Nmu9InBlDm6ZjPxLuw2dOdedDKFt
	iDZOhuT1emj4Yv/5si7brZqBf7SWLnNAR6UPIn2IRYnQ0PyZ7QqjwUaGZvZWXYPSgO94KwAahKq
	dOUFtfUeytYrwkiIsGe7e0VBDQ4p21A2ZRvzR6NVjBBll+0H1K5wOyjY1qZAuJ8X8taAFhlP
X-Received: by 2002:a05:6102:4188:b0:7a6:dfec:3643 with SMTP id
 ada2fe7eead31-7af1ebf3435mr5061365137.27.1790565390040; Sun, 27 Sep 2026
 20:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
Date: Sun, 27 Sep 2026 20:16:17 -0700
X-Gm-Features: AclHuK_QlrFRSnX2NHJDocTnLS6-fnJMHzvoTbOUc7y5VT8oJ3Zx5QQENKWETGc
Message-ID: <CAAk_H6GiVbRELEWOvxBT9UTCy9jo-NtO5zu7SZx_urkuSUbghw@mail.gmail.com>
Subject: [QUESTION] Possible off-by-one boundary in netfs_page_mkwrite() using filemap_fdatawrite_range()?
To: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

David and Paulo,

While hunting for bugs, I noticed a potential off-by-one range error at
lines 571-573 in buffered_write.c:

err = filemap_fdatawrite_range(mapping,
                                folio_pos(folio),
                                folio_next_pos(folio));

According to the documentation in mm/filemap.c,
filemap_fdatawrite_range() expects an inclusive end offset:
* @end:    offset in bytes where the range ends (inclusive)

Since folio_next_pos() returns an exclusive boundary, passing it as-is
forces the writeback to bleed one byte into the next folio.

Should we simply append - 1 to folio_next_pos(folio) here to strictly
bound the writeback to the current folio, or is there a specific reason
the boundary was left unadjusted? Perhaps I am making this up? (I am
new.) Advice appreciated.

Thanks,
Fredric
