Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB915442A
	for <netfs@lists.linux.dev>; Thu, 27 Mar 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115320; cv=none; b=u+sadwJN6pAT5fQ01oTk7CXMRR4KhZpwbwUh/mNu5JP7pSPBYbHlipx1YiK6k2RfZrQted+f49wzRCbgmJ9jvKouEkU1CiXlHCGd1tLH+tHEprzu013HlBLozUFmLBKFBmYHvl3BYLGHn71Qr58dBGTXPcyh8dGSnkufXf9pDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115320; c=relaxed/simple;
	bh=KHn/nBq0F9UMfUat3NZ4KUTGan8L84wLSAla2hC8Nog=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YHQXtQgMj1j0XQjscWdfgOpQsVJ+D9FAI9zvmxmmcmvGpTcJ2slgqHz5uWddJi3OQP+S0PbWxlQqCWM5b+sFNq1DjYYWXVhekFGe5EjRkNycobjndGucpg9EVzQrNGTtvCrmzNpW42btIh2Vvz+9QqNKLbqDbht0kEjlsP9dk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dd6WFfMF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vlE59MVG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dd6WFfMF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vlE59MVG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dd6WFfMF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vlE59MVG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dd6WFfMF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vlE59MVG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BE3D1F388;
	Thu, 27 Mar 2025 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbp6AL8rqFZj5ptz2a0aLb1oBUVouVYJ+S6YTpOTsp4=;
	b=dd6WFfMFzmonZQRX+LR7LaabCx+WnPZkwjmAxpdr8ylNS8g/rY6eR7z7EcHHB31liOzBaW
	fHvI+Wm9/8UxsMbzg1NxtuJdw9cSw97+e+5kdWMdLLIsPvx8wddBzdf2tYK7DzkTW20N6H
	KdAky7jAmOtKhbjxDP+jxIt04nOp2kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbp6AL8rqFZj5ptz2a0aLb1oBUVouVYJ+S6YTpOTsp4=;
	b=vlE59MVG3xmltYpN86oYk3LHFsYAJp9WaXsoF0VSwgJ6Lv1s8HefckacaVGeZ1wh0NSztg
	Slf99jSClD3snVAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dd6WFfMF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vlE59MVG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbp6AL8rqFZj5ptz2a0aLb1oBUVouVYJ+S6YTpOTsp4=;
	b=dd6WFfMFzmonZQRX+LR7LaabCx+WnPZkwjmAxpdr8ylNS8g/rY6eR7z7EcHHB31liOzBaW
	fHvI+Wm9/8UxsMbzg1NxtuJdw9cSw97+e+5kdWMdLLIsPvx8wddBzdf2tYK7DzkTW20N6H
	KdAky7jAmOtKhbjxDP+jxIt04nOp2kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbp6AL8rqFZj5ptz2a0aLb1oBUVouVYJ+S6YTpOTsp4=;
	b=vlE59MVG3xmltYpN86oYk3LHFsYAJp9WaXsoF0VSwgJ6Lv1s8HefckacaVGeZ1wh0NSztg
	Slf99jSClD3snVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69295139D4;
	Thu, 27 Mar 2025 22:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BN86CDPU5WdLbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Mar 2025 22:41:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: netfs@lists.linux.dev
Subject: Re: [bug report] VFS: Change vfs_mkdir() to return the dentry.
In-reply-to: <ee222b74-6aaa-40f0-8cd1-af0da9e41b37@stanley.mountain>
References: <ee222b74-6aaa-40f0-8cd1-af0da9e41b37@stanley.mountain>
Date: Fri, 28 Mar 2025 09:41:52 +1100
Message-id: <174311531246.9342.4749011922906183800@noble.neil.brown.name>
X-Rspamd-Queue-Id: 5BE3D1F388
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 27 Mar 2025, Dan Carpenter wrote:
> Hello NeilBrown,
>=20
> Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
> from Feb 27, 2025 (linux-next), leads to the following Smatch static
> checker warning:
>=20
> 	fs/cachefiles/namei.c:133 cachefiles_get_directory()
> 	warn: 'subdir' can also be NULL

Thanks Dan.
This has already be found and fixed:
   20250325125905.395372-1-marc.dionne@auristor.com
so no further action needed.

Thanks,
NeilBrown


>=20
> fs/cachefiles/namei.c
>     124                 _debug("attempt mkdir");
>     125=20
>     126                 path.mnt =3D cache->mnt;
>     127                 path.dentry =3D dir;
>     128                 ret =3D security_path_mkdir(&path, subdir, 0700);
>     129                 if (ret < 0)
>     130                         goto mkdir_error;
>     131                 subdir =3D ERR_PTR(cachefiles_inject_write_error());
>=20
> cachefiles_inject_write_error() either return an error pointer or NULL.
> Never a valid pointer.
>=20
>     132                 if (!IS_ERR(subdir))
> --> 133                         subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inod=
e(dir), subdir, 0700);
>                                                                            =
      ^^^^^^
> Passing a NULL dereference here will lead to a crash.
>=20
>=20
>     134                 ret =3D PTR_ERR(subdir);
>     135                 if (IS_ERR(subdir)) {
>     136                         trace_cachefiles_vfs_error(NULL, d_inode(di=
r), ret,
>=20
> regards,
> dan carpenter
>=20

