Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC3400990
	for <netfs@lists.linux.dev>; Tue, 11 Aug 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435798; cv=pass; b=CpgLPGXvJWDRUvQrJvqwHw0ju0pz+oKnzYqdIlbFsiz6mLXyTqcNLc6WOC6P+BGrgAByGWgq5/EqjsLDGROLDgGkAVsqKO7iwxCjm4MX4mjnYxpgfcsQ9G+C1m5PvdsPGHLz6JqCV1LFmAnHBjtxwTY4bJu3Zf8T0YRomPDI4io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435798; c=relaxed/simple;
	bh=lnwTgcWmbcIBg2Qgc8rEXw/pFK3g8h7NAtGPGlBFVOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJNiXAXJi/oEf5g1oqXvDpkSX7Zp1If0ySxXPlvSDmUex/OHzZKMZb8WXnTmFwC9qpT4sa0F5p4ttJ1Dl7Wbp/4X8lqE9d6F7B7MUZAMx4Mmcfw+Zrn2CpC0Hk/fBFtu8lLmVgERF8HN5O6McmCfp6lOiTOHsqSA6GFcZ4yTLpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MHCLuwjW; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MHCLuwjW"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso371472366b.3
        for <netfs@lists.linux.dev>; Tue, 11 Aug 2026 01:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435794; cv=none;
        d=google.com; s=arc-20260327;
        b=s8ERLwK6orE7k30nT7R9KIT9sJPQ3SxsqMLTp62SPhDH5ZI8cLNcpucB7hFm1dMxRe
         /EttZ+POcLsSZIFy4GVTNTT0TNOCive7McW8nun+pA05fFLNDx/pdC0vfxv7CuaLV6AE
         b1vpjWL1m0jmilxMQR+VTfkA3nqHQN/KK6viNpGnHe+mSOoItAqwZCtdXRA9To4ay7iE
         nBn+RdCsTDgYmmptqo/yDGG+q31aBD8Z24o53Jf2cHEkmSzyPtiUiu45eGulK9wQ0xXT
         l+WNozF7sLRguBAWZLnfqjHg+4Rg0wHQMm1whsdeEMAsI55tJvQn0rjpiZMzrwbQr4Za
         h/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        fh=YCHLuu/a8iwXXHwUH5cxSw6iRD5HuodZfXedic+gFo0=;
        b=KeVtmm6G3e6beRlHTtEArhWsoNpdtv54uXT4M30XeFPuXJT6bFNN5SMszG2YzuihTO
         5/OKZAIZzI2RssYlXcJkDEcFrmaeraHXhgvsp4wkCyY7YndZLx/3TKyFLZRkQvbfIqBz
         l+JivuJAlMpY8bF1E+3QKId7hPEhUR/mS6BIKZ4xg8sVf2HmRC6M43L41HUPV/wGktja
         E8H8TK0G8mTgbI34+HVqzcAECSIiFTq0rVkLNmQ+GuenPL/465+fhCMp+lauIxahbNpH
         J5M49qHgSqcfHRHoNv5C5iqQtg3NtmK2qiqzCVq7dG6E9nNxSzioycvruPKOdMPyKXR6
         Rn9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786435794; x=1787040594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        b=MHCLuwjWYHvCNJStSLJYr9Vqz3F7Jg0gQq6yW9Yi0cGkhgghIpX3xmnyfpyqNJLa8G
         55Zl/QXD4lnV6t4hJ4uFyPFaI1UMIre5Iol96xiPGFfTeLr6sSO6gDAtJ7y/J1m5pBcs
         mIN0J2c7bXX2lHj+FGNmsX5OL/dOaoiYUliBqzRVZ3lX9VdeUqAGiwtbJn9PPUcWCHGm
         9qmD1PAnmxhCo1JgrmFXlkerB2xa+qn7zgdjdkohwo6CMu/Sb4w8QtrF8kADDloBxXor
         tyjWcAV9pfGtpC8dKI52pWvnWI1pWg73AGdrbsRztQB/ShjeWcJJqgAj+4kwxineEZ0p
         IqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435794; x=1787040594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        b=KVOmQK72FEqQMLZ1vHEZFiw733KL+Xbd61+Ico9KL23/Tpx40v9PBBzcufgOvzYar/
         IblH/zpDLWT3M3ANUxcxkuZDIx4AAZ5l0wKgX3QDYgJVfTbdF5pfqH5RksREJyZPpN6a
         A8R+YAPJT9fKtBupQljSUhnxRR7hE9LJkI9I68ckynMGTwBsOyBH9VIWZBwCK0zO+vAY
         PTrr8eAgyY8RVfAECOiJMkPM041wpB9aqjmQ42EXLdzAkaV1GRTATca5DfLXoZhBIEM5
         4yZbPQ4/GISjQKLznwyjynFxGb2yuOkirKvCcznq2Av6LwDTM1PEN+vRyTtreNZJK0/N
         bK/w==
X-Gm-Message-State: AOJu0YymApCLAyki04DbRHhCKeNPpyoRlGxGO9x7ccv4XxTc53d63//N
	MTJ1W7rZAs056teXln4FZgEBakI2oiB1l9YMRDQMYQmsV3WYU+BcRD5LNQcpmOjHtuLKLI72ARf
	GcZlu/5iVyQdfrUg8+hsuCDjJahfKiPbMzBkMQWnOuA==
X-Gm-Gg: AR+sD10GTM0vEmnpZKCpSCxxl2ZqvneISabn1D3QXk86+m66tzzthr+R8tOhAtakHnN
	r+IOPDsLzMjv09o+xt/mjxQUmoK3gyHtGDkSyaoYzv0AvEkImbiYuD/h78tXjif5yjkT+QTvlW6
	VSUhIh4nJiRWMsNGRCfnQyB58POHk2QmM4YNpGnAUi6LbQZZ/CtvJveIQAOzyhKjpvm7LZNtMIF
	4Mg1y3JxqEi/NdL+HB7huumNsHDgk4kg5bCCfe165FyAxvqzcD9f8+V+Xhs80oWvXLIkJtCMs0i
	9K1rdbFD+qllN/wb0CGFHbVf1THCrrx60BbWrJt9pvYzImpwmlLJ3s7Tcgew7PSEgGC6NFpa67s
	XrQWNL1YPKQ==
X-Received: by 2002:a17:907:c14:b0:c20:83b1:396c with SMTP id
 a640c23a62f3a-c20e622569dmr56516466b.17.1786435794433; Tue, 11 Aug 2026
 01:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727130716.1099906-1-dhowells@redhat.com> <20260727130716.1099906-2-dhowells@redhat.com>
In-Reply-To: <20260727130716.1099906-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 11 Aug 2026 10:09:43 +0200
X-Gm-Features: AUfX_mwxuJUD9QwttfMG68Fi2B7SoG82gh9YWa1e7DmPzlVYbeVeeqOw4OhyccU
Message-ID: <CAKPOu+_iAa675Axx94Z15X12EOatM-FBCiG3UGN3zMT65rgNwQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] netfs: clear PG_private_2 on copy-to-cache append failure
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yichong Chen <chenyichong@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:59=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>         /* Attach the folio to the rolling buffer. */
>         if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
> +               folio_end_private_2(folio);
>                 clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
>                 return;
>         }

David, I submitted the same patch 4 months ago already, why didn't you
merge that?
https://lore.kernel.org/netfs/20260330105548.1371339-1-max.kellermann@ionos=
.com/

The "Fixes" tag in Yuchon Chen's patch is incorrect. Commit
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item") does not introduce the bug. The bug has existed ever since
netfs_pgpriv2_copy_folio() was initially added by commit ee4cdf7ba857
("netfs: Speed up buffered reading"), as my older patch states in its
"Fixes" tag.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
