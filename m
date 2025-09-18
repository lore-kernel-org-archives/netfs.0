Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AA258CDC
	for <netfs@lists.linux.dev>; Thu, 18 Sep 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171157; cv=none; b=rfcfxY7XDi/St1F0O2EDUUCYNNbH6AwzbknQMXwNgTbvZxt3/Q4QcqOyCRn31Hpb+yG/PJxuZ4ulpdjmlSPzXk+xJB2gOs36DdHbjuQIxPPHxD0F2l4xgwVBJ3e6BPtAxV/rCcs4fHYBrM2ci2FN/RNmDUkJCRGgO62ve3ff2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171157; c=relaxed/simple;
	bh=roMRSfTHwvWbIYHIw5SlvXsbEkqQ/myQD+bxde55/zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNTswbvfDpCiCqj5JSre2imgm3vZLEyzvpqscfFkm3byt3Js7bw2bTG0AcrJb1RU2jJ6Vh+tTwt42pUjj/JkABiwazPlFG/8ifzsQx8CTMDSwFPRsQvs7/e3IsBvjxKIUFkY1n2IRzaLjZneFUqYPD717pdT363P+rh6ykHlJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I2JxoWhV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I2JxoWhV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b046f6fb230so108152166b.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758171154; x=1758775954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=I2JxoWhV2mJlGyn8A9H5dLiMvn+1G7Z0Z0oX8GbcZsfzqqDPwNXm3mfqzEKcCEGAy0
         HisFE+x6I2MT6ZeLzgVo8b60e1oN3v4t9j/Sp6kHJPpb26AhJby7VfyHhGmxVoMKYMay
         z5fYeOHqRb9jmSupPMvnFetLnQByHAOz5By8uDNXPgLgH5JPYcJokTsKqrGInRDk7rYd
         jCzUFM0FRRIssWJP+e2zNHVdQ16G5v50ofansXfwBxXbAHEU2Eof8QRJDLfD+eGGnexP
         hr2Bi5pjfkw8ZYAkjI83paMY0ONu73fBMJN3Bmw6e675mfB/B7ODEBozXf2jioVai1wX
         KVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171154; x=1758775954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=lpUU5OPnXYIaF8pm0Mw265CH2BpzIUmz9xcnSmVVHkygrR1MDUd1S7dGlh3ckMG9/K
         C+1zGIwrDvLPsuQUXCeYXQFWzs865kP99E5oE9jPJ4PvzsmUrovm0cyuiM/ZKbijNhEw
         eTNzWyd2Tz+5WxcrGZIfl3wfnueAMzOW15p/P1vfL4WBLlG+JRJAGLludOj4oiivvRG1
         7aCoK9n+KLNQRx/Lw/+M5FsN4CoX8cg8yAlOlH1A6zlMSS0gubDzJC10d/4xL5ArusGQ
         b1uUAC839QhpWQMpSRm+PPutaOEOV81EyFMtchy17eySVzDFaAuI1pe/TFfgJ2ZRhPEL
         sqHg==
X-Forwarded-Encrypted: i=1; AJvYcCXlExPZ4GvTQ11tcBi7SXuENNF7nfc4AjPVZgzzWK4rEdkv5Sx9vSZmCXOXJXJtyYpIZaYeDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS4J00Y7vt5f0khMHV7fZsC65Ag5yi+W69MK+tU7QEqDHte+C4
	eubdbtz4WidaBM1sFRqSlMs0IBobxzB9rjtbi0a0I8OdW7CGwF7R7s9OJrKB/iDjSs+gW4ET2TB
	Q82fROuXeFqJbr78RxB7wl8cSpPt7vFYPZgpIlBRrsg==
X-Gm-Gg: ASbGncvi6JOwr/ZxEMKX68jyat9PTHyaefXOY+A4yZqR88+Ug01n3jd0qypoaxRt2C+
	l2QEn/9qBxWliX0NTdHuxITFEbQ74rzR+0l1i2QzRDhUKazVK8CxS6UHJqx9UfGNfphkFWirBeF
	d509KG5nG5ZSFjnLSgIZEH7Hg/KEAUjiQOiwCIjtgBB6lIQF7/JvY58jMDc8ocOSUvrXFBBhS9v
	pAi1v4RrWzLe2X6qsrU3/s8eSRBqIRAoH/Oie7uBeAgFx/6jidUstU=
X-Google-Smtp-Source: AGHT+IH78/YwtfdEEvgvHSMTlAUPH/eYqgNUZ9char1Npv5jG23ahXW8pg2svda031uaJNRKWZjE53pxWARfwi2BnY0=
X-Received: by 2002:a17:906:9fc5:b0:b19:f444:5bc8 with SMTP id
 a640c23a62f3a-b1faef71aa1mr223957466b.31.1758171154075; Wed, 17 Sep 2025
 21:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:52:23 +0200
X-Gm-Features: AS18NWAZzXNs77ONQtxSPqI0-tNgs2QxD25qWiDPS307ZO8zwzS3_Wc3r2CSBy0
Message-ID: <CAKPOu+9o4FfXQU5O=iEhi=aFWfTUZ-mJVD6qqVi3UTSsy44agA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +
> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}

Folks! Guess what I just found in Linux 5.13: commit 23c2c76ead54
("ceph: eliminate ceph_async_iput()")

-/*
- * Put reference to inode, but avoid calling iput_final() in current threa=
d.
- * iput_final() may wait for reahahead pages. The wait can cause deadlock =
in
- * some contexts.
- */
-void ceph_async_iput(struct inode *inode)
-{
-       if (!inode)
-               return;
-       for (;;) {
-               if (atomic_add_unless(&inode->i_count, -1, 1))
-                       break;
-               if (queue_work(ceph_inode_to_client(inode)->inode_wq,
-                              &ceph_inode(inode)->i_work))
-                       break;
-               /* queue work failed, i_count must be at least 2 */
-       }
-}

This looks very much like the code I wrote - only with a loop for
queue_work() failures that cannot happen here.

Jeff Layton removed this because "Now that we don't need to hold
session->s_mutex or the snap_rwsem when calling ceph_check_caps, we
can eliminate ceph_async_iput and just use normal iput calls."
Our servers proved this assessment wrong. Calling iput() while holding
a lock is obviously bad, but there are more reasons why iput() calls
can be dangerous and inappropriate.
I guess I can add a "Fixes" tag, after all.
