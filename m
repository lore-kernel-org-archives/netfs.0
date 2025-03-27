Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E8125B2
	for <netfs@lists.linux.dev>; Thu, 27 Mar 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115276; cv=none; b=DzGLaEvACVo5GSeG2cJRvrFs8XKinWUxd8qTBMyFyRzN5BTrerAqIMJAOEF7eSOibsM5KJyGTCdAE9Fttx3jCfOKdYbyxwQJS9yrPBDomacG+RfXwj1a6ivgBnj1F3ZLIS/bq1EG9C46Z/T7dgWQwSMqMJS1oSGmyUKMtsVOvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115276; c=relaxed/simple;
	bh=5vF2VEIll+nbmunkeAIzR57XTr7d4+B0Ywub9B08pQU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ifWDjQ+l3WGGuCru0EjMO0UzUkHlP9L4PS9739+vh3luiv7hx5sStTb+phxiX26z4Nt8vydLA/7ZvaYWIcIoU8nA8LVqPOuPiM/TYeQlAZqKmTjZuhMtd+XAC+W23fZFL+9MafsnPhGrD5K6Z5QV71QPvU/KdzYa7IgTFNYBqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FqM5wGCR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vd3BMtPD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FqM5wGCR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vd3BMtPD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FqM5wGCR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vd3BMtPD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FqM5wGCR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vd3BMtPD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 845D2211AB;
	Thu, 27 Mar 2025 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyyBv0MDhyXCRlumN9tNdad83XBQwuSIRjL+sSn/aIc=;
	b=FqM5wGCRqaheNu7ExCv9gpKqVt4eOOhPxlmk6LjiSG9fnCC75B+KhNKEHyW8QVs+S95ucZ
	xCir34D689r9c6qu6Of2BdGQGrFwARnWDV5ayROgY5HJCaIUH4PehjyXDdWiYdyw4msqp1
	CibKHEC42AsOfFQdET4KpieFXq8DJ+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyyBv0MDhyXCRlumN9tNdad83XBQwuSIRjL+sSn/aIc=;
	b=Vd3BMtPDplJY/AzWUC1ZJ7Rgm2Imm0hMX0rsUwZY1X//xMeDCJiiS63R+9zDcJ0FYKayMT
	kiowBrYfWagH7uCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FqM5wGCR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vd3BMtPD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyyBv0MDhyXCRlumN9tNdad83XBQwuSIRjL+sSn/aIc=;
	b=FqM5wGCRqaheNu7ExCv9gpKqVt4eOOhPxlmk6LjiSG9fnCC75B+KhNKEHyW8QVs+S95ucZ
	xCir34D689r9c6qu6Of2BdGQGrFwARnWDV5ayROgY5HJCaIUH4PehjyXDdWiYdyw4msqp1
	CibKHEC42AsOfFQdET4KpieFXq8DJ+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyyBv0MDhyXCRlumN9tNdad83XBQwuSIRjL+sSn/aIc=;
	b=Vd3BMtPDplJY/AzWUC1ZJ7Rgm2Imm0hMX0rsUwZY1X//xMeDCJiiS63R+9zDcJ0FYKayMT
	kiowBrYfWagH7uCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0915E139D4;
	Thu, 27 Mar 2025 22:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bN8SLAbU5WcZbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Mar 2025 22:41:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Marc Dionne" <marc.dionne@auristor.com>
Cc: linux-fsdevel@vger.kernel.org, "David Howells" <dhowells@redhat.com>,
 netfs@lists.linux.dev
Subject:
 Re: [PATCH] cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory
In-reply-to: <20250325125905.395372-1-marc.dionne@auristor.com>
References: <20250325125905.395372-1-marc.dionne@auristor.com>
Date: Fri, 28 Mar 2025 09:41:03 +1100
Message-id: <174311526371.9342.7621229997134615298@noble.neil.brown.name>
X-Rspamd-Queue-Id: 845D2211AB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 25 Mar 2025, Marc Dionne wrote:
> Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
> changed cachefiles_get_directory, replacing "subdir" with a ERR_PTR
> from the result of cachefiles_inject_write_error, which is either 0
> or some error code.  This causes an oops when the resulting pointer
> is passed to vfs_mkdir.

Thanks for fixing that - now that I look at my code again it is
obviously wrong :-(

Reviewed-by: NeilBrown <neilb@sue.de>

Thanks,
NeilBrown


>=20
> Use a similar pattern to what is used earlier in the function; replace
> subdir with either the return value from vfs_mkdir, or the ERR_PTR
> of the cachefiles_inject_write_error() return value, but only if it
> is non zero.
>=20
> Fixes: c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
> cc: netfs@lists.linux.dev
> Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
> ---
>  fs/cachefiles/namei.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 83a60126de0f..14d0cc894000 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -128,10 +128,11 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  		ret =3D security_path_mkdir(&path, subdir, 0700);
>  		if (ret < 0)
>  			goto mkdir_error;
> -		subdir =3D ERR_PTR(cachefiles_inject_write_error());
> -		if (!IS_ERR(subdir))
> +		ret =3D cachefiles_inject_write_error();
> +		if (ret =3D=3D 0)
>  			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> -		ret =3D PTR_ERR(subdir);
> +		else
> +			subdir =3D ERR_PTR(ret);
>  		if (IS_ERR(subdir)) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
> --=20
> 2.48.1
>=20
>=20

