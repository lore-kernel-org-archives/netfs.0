Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B62030A;
	Tue, 27 Aug 2024 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734979; cv=none; b=DnGDqc7Jjl4CSozQqHHP7y1dXHv/jgOC3sO/T9sD5BpIguoc7pZvO5X33IOwbc2IXpSA4D8hmEmwl0f8be+dkINBZ+AHffzeaVG2SuOLasqDZGw5YA0xkFYdkxqOoK2V5UHlvCaddT9S19F/3SEuqjMfVoaMKb+z2+FsMhuwHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734979; c=relaxed/simple;
	bh=8y9iQ94NHXc4cCJ1Ma/iTj2MrsadbqKcnH8mBLcgSus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxqTjsa/7JFJkgsRJ+NdQ+NsBWCYyfKo3zq+WDlnNKYi9OFFZFco15155mSvTWq/Buff0RAgo4CSChn+rarKGW2sO8TruNTqkJtW8LMiyIrcKpANBKoEgSXnkGXGHV/v4hfc+iFSXcW13+Qk8VikXYjJl3tqMW7WgKcx3zr/u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0/zMMeh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0/zMMeh"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so4913082e87.2;
        Mon, 26 Aug 2024 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734975; x=1725339775; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1tPrUcxqAg1dhruM6WccigDNxnQ/dFY9k4RpKAhaVQ=;
        b=J0/zMMeh9QRwkowpFhk5/RgQwwCwgEtxmXmwP2lAhwYcmxdi79XU6opxIFW//ozHyN
         MX7B7NnjeptaRBBXIDxM6qlQ9WTrKAnuPTk8opO5zo3ytVqqq2MqRfPBzYWxVhrC4OdM
         1DVtzRc0jPAjXsNtOsXbo+OCSUA0pEYJKCRfVsl/GzCb1PogV3flcpSLpitrvsdL/1x3
         3lpC2n25GaoUsptgdCwruyh8UG5u4oCUcrlAzCCiV7A4tqfWKC3uUcqp62A/owIfTuv9
         Ow0bEHes7J/igU41dae6hOvuv7WrnAh3uxBAv4fn3LU6YSP1BaC4snzNsEq+uvxhVyGj
         wEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734975; x=1725339775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1tPrUcxqAg1dhruM6WccigDNxnQ/dFY9k4RpKAhaVQ=;
        b=VMHqjAkia2PHkRiGtL4OJ3u5tAKyA+rJyR2W0Nkcr9GjEHJy1A+/QE38W60z8EGvNx
         xC0TuYlN81bNdtmyOzUgwLqo79OgBwnbd+2Y5DytGHBXdozqKIwn/+TdYh8JKkbhruo/
         PVSqfUzc6t31GBs07vXj11DE0aiuJgWQSHfR8i4/C3NiHdksyCudcShsgZj8qRUGrn7o
         h2LN7wU6ZFehsxIlyPFI52jmT+2HGvQhRThDCKmv5lHtKg9s4vAvAFycEWciPngKN0UA
         Kk5N/9Zp1q1UhcmT43gvpQpIDo53XaovS/a2WuB+0R3eYb/LLdep7rcpIHE6Gq75i+F+
         29hw==
X-Forwarded-Encrypted: i=1; AJvYcCUMKzOZxW2iL9p0Sv/0yvn05+cWyQTSeIq/aAIPtBpwDI6cTdiRdQ89VcUYFdiivJArFegqG0Bv+q5f2cQ=@lists.linux.dev, AJvYcCW3kwk93Mln3tkIzbsb0UjUD6vISyetiNfI9ZDtAsSK9jSyyKM2gP26FGc1DhFgSuQGnW72yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfqaspdhXBBLP84olMQW4GvjXNliZRxOriVLqf6p1FXXdxtRwE
	VDAacGN5LV625oWrxlKTGr4hYTINqshJhZ7CgmdDz9ZQTa71nKJlEBBq6WeTYnwPWJo3LXafsGi
	yykGETo0TtgjSMvID+gNo9w2CW0g=
X-Google-Smtp-Source: AGHT+IEOrUFWw153PpKJ3xQn15rauhXsECsIYW+gk4XwZMm21Fv4vuqd+UVgtsNTZLpMz8YCZ3pmYmlPkiXIS9hAPok=
X-Received: by 2002:a05:6512:3b27:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-5344e3de28emr1038984e87.29.1724734975021; Mon, 26 Aug 2024
 22:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net> <CAH2r5mtZAGg4kC8ERMog=X8MRoup3Wcp1YC7j+d08pXsifXCCg@mail.gmail.com>
 <CAH2r5mt99dz9AjEYvMpBUXoNLePdbK5p0OuH0Lq1tf4m+ExLpw@mail.gmail.com> <Zs1YKh8H0dEX126X@codewreck.org>
In-Reply-To: <Zs1YKh8H0dEX126X@codewreck.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 27 Aug 2024 00:02:43 -0500
Message-ID: <CAH2r5mtCi52Fd_OZE_8Fnd3SmTsD3SUkj1CEsU6jw38wTuxskw@mail.gmail.com>
Subject: Re: [REGRESSION] cifs: Subreq overread in dmesg, invalid argument &
 no data available in apps
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Forest <forestix@nom.one>, David Howells <dhowells@redhat.com>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:38=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Steve French wrote on Mon, Aug 26, 2024 at 11:27:33PM -0500:
> > I have also confirmed your theory that the regressions (there are
> > multiple) were likely caused by the netfs change added between
> > 6.11-rc3 and 6.11-rc4:
> >         " 9p: Fix DIO read through netfs"
> >
> > But reverting the cifs.ko part of that patch alters the error but does
> > not completely fix the problem, so the netfs change is also related
>
> David sent a bunch of cifs fixes including this patch:
> https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com
> "netfs, cifs: Fix handling of short DIO read"
>
>
> I don't have any samba server around to try myself, did you have a
> chance to have a look?

Yes - I just verified that David's latest branch does fix the problem
you reported (ie "cat foo" and "xxd foo" on mounts to Samba)
I ran with 12 patches (listed below) of David on top of 6.11-rc5 (and
3 unrelated patches from my for-next branch), but most
of his patches are not in linux-next yet

540511907bbf (HEAD -> for-next, origin/for-next, origin/HEAD) netfs,
cifs: Fix handling of short DIO read
76b6078dcc72 cifs: Fix lack of credit renegotiation on read retry
de7b2d4f8789 netfs: Fix interaction of streaming writes with zero-point tra=
cker
0d718d75935d netfs: Fix missing iterator reset on retry of short read
eb54e19d9cb8 netfs: Fix trimming of streaming-write folios in
netfs_inval_folio()
b10b7505454c netfs: Fix netfs_release_folio() to say no if folio dirty
5fee95cba515 mm: Fix missing folio invalidation calls during truncation
68c4ccecdf68 backing-file: convert to using fops->splice_write
65a5aad19a17 Revert "pidfd: prevent creation of pidfds for kthreads"
3e99ab871c90 netfs, ceph: Partially revert "netfs: Replace PG_fscache
by setting folio->private and marking dirty"
06f646e2d0d4 netfs, cifs: Improve some debugging bits
416871f4fb84 cifs: Fix FALLOC_FL_PUNCH_HOLE support
017d17017436 smb/client: fix rdma usage in smb2_async_writev()
b608e2c31878 smb/client: remove unused rq_iter_size from struct smb_rqst
c724b2ab6a46 smb/client: avoid dereferencing rdata=3DNULL in smb2_new_read_=
req()



--=20
Thanks,

Steve
