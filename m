Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E42B9C6
	for <netfs@lists.linux.dev>; Wed,  4 Dec 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316117; cv=none; b=MQXY0gP0ndfX+0B3ZThvjfg4FngCpEsviMQpnn+/1NVbX+aasUt+VZUfIDG8Gf6gsIkBq/cZdyGa6opcz3BCd9kB57GHM6jHvleBSElR6emOHlNk+p2uDZZIyg4ZUkYm2z0uj5MLLTFhMoqpcx+pGNxoyhFmBKdJT5/vEGVCS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316117; c=relaxed/simple;
	bh=CA8V7r/HHu+tdRQoB5cE5pMef+kvwPPpVBvOxT59EbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF9l2vklZRzoNYTu1/ZIAynqymQYSmbH/KVUzBvEi2mXXBKaGSQPk2DMR9H4VmNR6A3EaS0RM4U/keOEpOEgesClWnU5BGH4dcTgIvLFhTc72ECOkLc6K0HNRz8PanmWMtaDw2s1Gh2Am0iJzBBHAiBn7KKit1ahc2+3smqqZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AIWUtBrD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AIWUtBrD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46695478d03so58629831cf.1
        for <netfs@lists.linux.dev>; Wed, 04 Dec 2024 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733316113; x=1733920913; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8llbzjZ//9+h5xfG8QfPKdjzTna7E693fwr0oTRJmW4=;
        b=AIWUtBrDYk/1bEQ0CVyo+UKwdvorU0lV/PFUmN/ARfmoFFAD4I87OZ805L3Gy7nM6V
         +skyV/OL9mfIJkN+UQGzWl6DcFztVm/jUXoyTXKBY+fyF+cARsiwrH2CzVdH08JfIgdj
         jTI/qzAHHfUHSxBaQTVfi711O3ZPrkCJN7t+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316113; x=1733920913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8llbzjZ//9+h5xfG8QfPKdjzTna7E693fwr0oTRJmW4=;
        b=TFrebmKMLtyulx3CN61lsJe0RACduLdX4U3ejNaxN+s+wP4RFD688BDfySLY0mWK75
         SgNBR83/W5p7EE3Blue10YemLgESqjl+dg/U7i39Q11oEpWMF32Me94SM9ZXwXs9fJFT
         FQYrp+oHg/KgscmXIw6O2pOMA5fgSPj+rGK5KPFesr6EvymDxxFaxriYLbEcMRtWIFdM
         Muw9EWflMW+zWxaoD7QZrdo0iOvDno0on+TBgwyEDN31CPurODJvAj0Yxighl+PK1+Ib
         JboV7zCUS6zYybMgLM8zNRjWsTLWd4Se/RYDHLX2PsPKVFtNT9kp1dKd2BNHZ4cFq+G3
         0Xpg==
X-Forwarded-Encrypted: i=1; AJvYcCURYxwrfwrCxKNz/s+CkN5ENb87dWgabW2f0fzDLI2dgn8xIGgi5M4FERLXpfqxyNqiA6QwZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxtgcXFiw6xO0rOA1C2+MFIEUreZzDChXffBWnrSYGDb1Cjy2g
	sU55kRhnZX3QvZr+m5NVma+L6Rf/y/AhU7nHz3pHqu3LXhtg60QQx4byVFXZXfNfdm1oMMeSiMs
	p3WLZjNIx5VDX/EIjw1sIeFJ+lgDMK/1rUXgPbg==
X-Gm-Gg: ASbGncuCwl/lQYzqDtMx35oqUxQaY+FGhsFQHJZQ4sMS8HOaW/Pp9MHM8diMWQm6TTh
	/uktE7qWE4UeBJTnTyMKU09Fq9AqkPUw=
X-Google-Smtp-Source: AGHT+IFr6bGymy7YeT0tDLIC2vZBdlTOgMsR6dCpqF9+A8uFmv4A9jCBRMqqTxj1MwINnQpAGUucyxS8LL7NJH0OU2Q=
X-Received: by 2002:ac8:7d41:0:b0:466:949a:de53 with SMTP id
 d75a77b69052e-4670c75800emr96854181cf.56.1733316113334; Wed, 04 Dec 2024
 04:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241202093943.227786-1-dmantipov@yandex.ru> <1100513.1733306199@warthog.procyon.org.uk>
In-Reply-To: <1100513.1733306199@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Dec 2024 13:41:42 +0100
Message-ID: <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com>
Subject: Re: syzbot program that crashes netfslib can also crash fuse
To: David Howells <dhowells@redhat.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000003856770628711b29"

--0000000000003856770628711b29
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 10:56, David Howells <dhowells@redhat.com> wrote:
>
> Interesting...  The test program also causes fuse to oops (see attached) over
> without even getting to netfslib.  The BUG is in iov_iter_revert():
>
>         if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
>                 BUG(); /* We should never go beyond the start of the specified
>                         * range since we might then be straying into pages that
>                         * aren't pinned.
>                         */

Can you please test this?

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct
fuse_args_pages *ap, struct iov_iter *ii,
         */
        struct page **pages = kzalloc(max_pages * sizeof(struct page *),
                                      GFP_KERNEL);
-       if (!pages)
+       if (!pages) {
+               *nbytesp = 0;
                return -ENOMEM;
+       }

        while (nbytes < *nbytesp && nr_pages < max_pages) {
                unsigned nfolios, i;

(Also attaching patch without whitespace damage.)

Thanks,
Miklos

--0000000000003856770628711b29
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fix-fuse_get_user_pages-alloc-failure.patch"
Content-Disposition: attachment; 
	filename="fix-fuse_get_user_pages-alloc-failure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m49vmnzk0>
X-Attachment-Id: f_m49vmnzk0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggODhkMDk0
NmI1YmM5Li5iYzAxOWZhYzBiNTUgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xNTQxLDggKzE1NDEsMTAgQEAgc3RhdGljIGludCBmdXNlX2dldF91
c2VyX3BhZ2VzKHN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMgKmFwLCBzdHJ1Y3QgaW92X2l0ZXIgKmlp
LAogCSAqLwogCXN0cnVjdCBwYWdlICoqcGFnZXMgPSBremFsbG9jKG1heF9wYWdlcyAqIHNpemVv
ZihzdHJ1Y3QgcGFnZSAqKSwKIAkJCQkgICAgICBHRlBfS0VSTkVMKTsKLQlpZiAoIXBhZ2VzKQor
CWlmICghcGFnZXMpIHsKKwkJKm5ieXRlc3AgPSAwOwogCQlyZXR1cm4gLUVOT01FTTsKKwl9CiAK
IAl3aGlsZSAobmJ5dGVzIDwgKm5ieXRlc3AgJiYgbnJfcGFnZXMgPCBtYXhfcGFnZXMpIHsKIAkJ
dW5zaWduZWQgbmZvbGlvcywgaTsK
--0000000000003856770628711b29--
