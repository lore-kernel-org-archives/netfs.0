Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0B35DA4A
	for <netfs@lists.linux.dev>; Fri,  3 Apr 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199151; cv=pass; b=gnghcafMoseTAz+aUgYAbrSsa4XlJ1IfPWZ9ON3em4dWnBJ/JmFtDzFUeEsfzIOSFzh4b/UDbj8qRup9/Or/BE74SmLM35SI4kCjzAUk3PpULrzuG4+ZGs6V7BTH34lV1iL5+7lFRM2CTd7bNEoNbm2YRhwIIVDslFh4w1FuWRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199151; c=relaxed/simple;
	bh=bS9Dm9mhURUVbT1hegVPADxmmEiYALh89sOuz/kJvow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBy1zqFi94MEWOpQIXFk7Fgm6FYDjRhunyxfid6kJXI0X/JQdqN2fW5pIZPb8ZG+608jTpROkYOH5FFS2PF/zuO/kxtR4LPPXJyF7xrPqIujyOX7Z1buQqxWyUtXLox7xvNsTq/dy8lRoN8SzioSkxuXTRmWtrFjdLy6feFpzv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eNgxyo1o; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eNgxyo1o"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b982d56dac4so284549066b.3
        for <netfs@lists.linux.dev>; Thu, 02 Apr 2026 23:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775199147; cv=none;
        d=google.com; s=arc-20240605;
        b=EMDm1sKDGslH7HnSEBRuYet/PcVLDZu0xy/L4AMOMa/AX+1XG0XDwlRB1y7APzQMqm
         BekoRCUZCFxV87sPAlaeME4QlxhIBrtuKtb932Hvozf4ZSHePO1bR+t03cpOZWHovwkD
         quFuThe71VKPm0rkd8B8Q6zUCRn6Woa37j7SsHzOx5e+er6rIKUA4w1NlGE1D4Oqgawj
         pRqhm2kZRHY/pbgHiMtHA/H8Ex44NHj7Fr5MR1QC1Au37k1Zcn/BOitX8EgAcXquk8N5
         tqpBrLyl1zUnILJ6AFkJdpht1n8k0Z+JJAWJcv7nNrygKWde63n/VsSKwaUzU9UagbT4
         gK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        fh=rp1l7teYGnGPeYpmTUOa9UT0waRlHMeqmMzrsk+ZFkM=;
        b=ZAabZkFkTU2czRErOKA70QVU4HYhMtq7DaS/3HoRWCfci1L0qTwRFm986dWQ/+EwGz
         ghfP4pMbb7u9xeoIY6JJufdbiu8gnD2XDvAjY/OnXfRRHxur6WqLBcGobBREDpqc17LV
         xjFv5Evya7z/1AbhG7CC1FFqwNPJCKvQzqkJL+1XTECBD+lAoq8nop6Ah+qGL3oi2V7x
         rNbIW8hRRHJIxVTTwD8yY9xrwhKhOhgkJ186KOEeDhaDRadEgn9zkFSWtHdAoZplv+TM
         sEMzAe90xZnWGfKxXu4k43HcDM8pHGalH+JpJ9OyBNr+1NPJDPRbg2rmlMSK51KODHEB
         zObw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775199147; x=1775803947; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=eNgxyo1ocJtAg77Ya3WsuZQMtKM1DAbt5wdsMJoX6TxfaJZAc1E98/mZYMZAf8WDO2
         R/o6k1ilJoZ1A8/iOwKScRADylNTYuEUbw/TistFuPlw/V3ar8lLOt9H2rGChUgDHJrL
         R0l7WT7DTDHUT37uHX2PCShlz7mptwNolOiRXXAr84es4inN2U9MmAvn3aY0Z9eSqpwt
         iFi20bHUxG7xtUgD4jnfrLGm/H04Oe4220ow8Ig8hlVt3fpablEYFIKBMvTznqBQPpEq
         uMMsVBonXTnp3AgJsKMe9VsU8W74+WgVByVl0GLJB4as5Bs4rRtPyg70OH8T3WnBLkp3
         IFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199147; x=1775803947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=Zhpb3uRD8hOGu3eVI/eVBTxp0we3H9dXf5iZEy8Dh0kJ88OBKDL4keM5fK1rqopYmi
         osdkmnKkon6IvwE5+JvCxrsuoZ/NH7VcjdyhuT+raZP9RdvTTsI1ntAC869voQ7sjGde
         4ZcqFlkYqXDclYVVZhpFkXc8Hqu/cF31WJwTXHFiVv+uWFXb1ooetAlsjHZAguDnvMSE
         CSZtQ/OqfGuFKnzEEm9jbNGHDvkZ7BA2MKYFEJuCx2ndRIRl4Sp9e3IodoW/MmsX41NX
         ZMBj+3+igw8sj2UZmA2tkbEjkq3zlHU7YoVpTavpM2JUJCVsRGh2Rec6ActWSml33DuZ
         USNg==
X-Forwarded-Encrypted: i=1; AJvYcCWQCXpkstxdqPxHc5iAeueO+StXWQ6taqAPjMnJMG3GimaQO5yGgT1tchckBilCaWhb3gOqXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsZznItPKHCk6W0J+LXJNB1ZKtQlO/mFlf4uke9ZaoxyJmalX7
	2VnYGpotsxMDczVzC+wAPtOBYAUbqPbKzFEWTvcTyc8JmDAby7+Hw3K6K/0OHf5bSz3YJXK/Gh7
	uYzK+1q+2tUgNfQoMkpBfwRkOKpcXVx7xucu5+qbhkA==
X-Gm-Gg: ATEYQzwb4aj8y36QWq0jqnrwP48WxrqAgN6tyjPX2vpXr+nJLKVGNCHfyx/y8O14ay1
	DOxf3mBKAxM0GCV9XVPo+foc8RkgAcD7y09mjyS4QO5kfDS7QASWq/nFxErjfP2ujth8YanN41w
	XuPQrf80s/XjGCvgRXx9jGVZMxomM/m3D7d2qDhENTo1Ndr+uqVZh9Q39bRG4rCNtEgHw2eRzuZ
	Uxm+MhF5fNM3xmQrflZufKF5whNb91ASD6Ui92YwDgk530OEIG49TyoTjb51py6GSReMJVh8KlP
	4gGioZUFqdN0jXAprJOXya3wwqmDIp6i6Myb
X-Received: by 2002:a17:907:9705:b0:b98:13de:a16 with SMTP id
 a640c23a62f3a-b9c67a10a98mr105360466b.39.1775199147467; Thu, 02 Apr 2026
 23:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com> <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
In-Reply-To: <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 08:52:15 +0200
X-Gm-Features: AQROBzAb2FJMqz47kp_fUlVSscz-fuNH21mTcT0GdyVezs8Qc3TsiivUaE4x7DA
Message-ID: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> The Ceph write_begin path calls netfs_write_begin() but does not pass
> IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> folio_test_dropbehind() would never be true on the Ceph write path right =
now.
> Does it make sense?

Yes, see:

> > ---
> > Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
> > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kel=
lermann@ionos.com/

The code in this patch is not reachable until my RWF_DONTCACHE patch
is merged as well.

> Are you sure that caching should be always true? All other calls checks t=
hat
> ceph_is_cache_enabled():
>
> bool caching =3D ceph_is_cache_enabled(inode);

This function is only called if caching is enabled.

>
> > +     *len =3D 0;
> > +}
>
>
> The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> CONFIG_CEPH_FSCACHE. It doesn't look right.

All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
code look right?

> > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *map=
ping,
> >       bool caching =3D ceph_is_cache_enabled(inode);
> >       u64 offset;
> >       u64 len;
> > +     u64 cache_offset, cache_len;
>
> Why do you need to introduce the cache_offset and cache_len? We already h=
ave
> offset and len.

These keep track of the region that should be submitted to fscache.
Folios without "dropbehind" need to be excluded from that.

> >  new_request:
> >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> >       len =3D ceph_wbc->wsize;
> > +     cache_offset =3D 0;
>
> Is it correct initialization? Frankly speaking, I don't quite follow why =
we need
> such initialization.

Technically, cache_offset does not need to be initialized as long as
cache_len is zero because then its value is never used. Would you feel
more comfortable if I remove the unnecessary initializer? I wasn't
sure which approach would raise fewer eyebrows.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
