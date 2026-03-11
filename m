Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF143D332F
	for <netfs@lists.linux.dev>; Wed, 11 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226063; cv=none; b=CHLLVu7QAi61s7sav16FR0q/NTzo9AxDAKEwrFN4qAwmZqm60B02HgdXWGpSm98arDDK3nERwlM0Dr/N9qgw9HvX5Cfp84fCf1vQgOlk93jQ+hhnGeFqALoJNsb/slquAg+EK6RvW4WnRbb/EyCKh+cwmnBJnjuu/ORqFgoabd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226063; c=relaxed/simple;
	bh=zRCIOZXGAulewyBbqGE0TlQlTPqeFeIDTbPGyy24MV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9H/POrfkEjTm2qkiX+bSktGcUZzpfugSivwWkLkONMy4O2ovw4T+rcSIRDys7OFw2mEtzDTH/ly82iZdmkudTFjHHZDxYZXca/cpVV0/e/Xu9Rikk2kcYaKMk64R/D5F77QgXVO56hXruiskFOEd74asrlt/8GtRIIOs+OfYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU3dKPp2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU3dKPp2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9529145e9.0
        for <netfs@lists.linux.dev>; Wed, 11 Mar 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226059; x=1773830859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=aU3dKPp2duUrQNET//pjg1VpIJAQ80/CnZsrv0pqjZnHUubIKgP54x0UOCa94ozCHI
         7Ja2CgYBv/SGayR1wmgXqHaAV7TJGJ/GmBZ5fW8uQZzGc9GXWbmpcltqPs0w11qp3ldj
         iof30vpQnpWDL/Zv3sY1ACmip5ibGqXtdNrDFYI2fgOKLO9yu/DHoWS7FssrSJADuUvO
         vL7HrzKIIujN2H6gUF4bgZGBnDWuzHemrsILKMsX5PVuULH4Q89/0IEIYUUc2sqAoHTr
         7IN6DvcsmRFSOp/0YcIaraV3xJpbTR1572BcItKgbJcgqCfhPTMc7A1UZ20JI7QlbAW1
         o+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226059; x=1773830859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=xU+pNBDo84R8bJIQ/sD/wN7OkohrBBBFJ8jlVDm45723wFI1BXGlLRHGDdNAw0M4dp
         EOB/WdNUGfIezCXJevu3gcOh2mNfEndx6QeNyPPf1w+ecH3AxpQLaPgSlJu/X4JE+M5O
         qHITer1FSCfda8/RXQZ3GfPmmFNnZzHu39KJioKOfbVhI6bHTDM4tpZzSh/h+bBAZAXx
         4SvpIdd4BEeYcLbT6Uud13MeBBSud5/nUIlBviz4N2uwwrPDMqP61OVjaayt9KwVtRuE
         DwuqvDw4LQ288waq1z1BuK9YO5DOAlXynCoQjxoW/htaXMrWFoGg8eQSjPlem0TL8VsU
         o5BA==
X-Forwarded-Encrypted: i=1; AJvYcCV2VjjYDckY+cD4v/r9DT4qJXSyvPO87PrvtVZoG3nFY8KWZmwMybn8Zn+mfWVOIVcaFxlffw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtHQ24UlIoqpqSUUVx1EJq/SrPkV1PmkjNO5Jz0SnEYL9IAtgy
	OOAXOZ5ZEUf6f48nD9SUwy3KAOyWg9Q7GQMMvtVFaARvXPNceEl3mYjk
X-Gm-Gg: ATEYQzwfOXRQZ1PEl3WpBthOhbyVvTnLEX2lSQ0b13r8uC91UN9t45Jwc8ZoKrjnpnb
	o4BYwN+w0ew+EgzUBLTqUKj44jxZLZt1GMqMDVbGMZmLh/eWNrsu7pDL0/g/uTk9XOhVAjSnFuf
	QwJY3yT2/ZxA8MtNIdkLhgBDhvefb04HSI6P9/mx4jxc+DQdVqCDgYEPlfPupOJEsEkdy/IepZ+
	OPFM2jNoHdKE9mkceAwlC7/RhkNUMVOnTEDesx0jNFmZorJh20y1350hb3QYnZyCOTNy79PA8xP
	dD6MkGdwXSrTl/sxNm61gaEcQH0HTPVJu+P5t+OB8zB+greExG2o3bHKowCT8F3IcUuYiFC8vVi
	jCqiRQk6mMiA0/sIhX3bVnS/oj7WKaZWHvyJ5oktVSh0d76vD8tZ+bN5LqPG51RYW2+RIdGGvNw
	ECsUYCe57y6VdJiap6dadwCQbQel98vuFvRdpEpIj/icGOU0S8hBi60Z8QpqHplk2GjfFDSNFI+
	hk=
X-Received: by 2002:a05:600c:5298:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4854b291dc2mr30148705e9.15.1773226058755;
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm5725154f8f.30.2026.03.11.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:47:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfs@lists.linux.dev, io-uring@vger.kernel.org, audit@vger.kernel.org,
 rcu@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kthread: remove kthread_exit()
Message-ID: <20260311104736.51b53405@pumpkin>
In-Reply-To: <20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
References: <20260310-work-kernel-exit-v2-0-30711759d87b@kernel.org>
	<20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 15:56:09 +0100
Christian Brauner <brauner@kernel.org> wrote:

> In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
> we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
> We left kthread_exit() around as an alias to do_exit(). Remove it
> completely.
...
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> +#define module_put_and_kthread_exit(code) do_exit(code)

I'm intrigued...
How does that actually know to do the module_put()?
(I know it does one - otherwise my driver wouldn't unload.)

The corresponding try_module_get(THIS_MODULE) is done before the
kthread_run() (and has to be 'put' if that fails).
So there is an explicit 'get' but an implicit 'put'.

While a loadable module that creates a kthread usually needs to give
the kthread a reference to its module and then have that reference
released as the kthread exits, I can imagine cases where that isn't true.
(Or broken code that just hopes the module won't be unloaded just
as the kthread exits.)

It actually makes me think that module_put_and_exit() ought to have
a 'module' parameter.
Or, perhaps, kthread_create() should have the module parameter and
hold a reference to that module until it exits.

	David
