Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4E12C801;
	Fri, 24 May 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564826; cv=none; b=Ck++1k2HQYY0DECPRS4XgjGxG+Ul/0f0D/+IEEmW+lPdSLXTgjzbhmLcnWAhxCRSvsE/WlUrTpLydjjoBZRk37XYeNrsUZlCfefETkDrhvUcNfJ4VuO0BXmAgH3kPbcDvff28anxZ8ZACSEQ38c90MGxgUIKoRYofBAGXkeJf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564826; c=relaxed/simple;
	bh=7I+MlrFIcsAFr6aFArGk9/6RkVyXb9ZMH8J1XJK4E5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn9gFszrrYRZ/O+0ulYK020yEWkXBvGosWdBHwZCZO650wDh9TsxQAJed0+Qy0Dskvi1mO+AghBBq+vviUFwnxbtuH+2JtS7liHk982Nhn0bbXTkyH8pXO1qgn10S3PL0+wjedr0LgWylANdwJXjXNaqQ0R6u003NLgF3NiUHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwmDzbqi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwmDzbqi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so3198776e87.0;
        Fri, 24 May 2024 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716564823; x=1717169623; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ptPH/gKMj44mK+DBZPwcDgch/F6jOYOlhSFCQQooJI=;
        b=bwmDzbqiIZpDlL5jje/fRNG+n6xNydGHBY9ejhso95/+WG9FjF/k5nnMnqykOMhJDB
         zfnmlhD4jwC8tvFP9bkg4KhX8Xq+6AhDGeekPk8vDmP3xaHvku2OkU+wUFcoBWRtAFpA
         IE3NDHTuS5uzdGm+fNp0MZN4LGwDC8Qnxf71Tso/frC8ayD/ueWfE6nEx+vcvDtpvx5i
         ubV5ucwzBM+hOJX2gF5TWjaIe0ik47zoYont6Te3nLats9xYn30rDJ+PSjOkfdEa0yI0
         pZSrXDxOI9zAHjccExF3UOYWYZleawDj8sdPKSU6uPS0gz7+WF0ED7b6qo4gPjdSrNdw
         coMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564823; x=1717169623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ptPH/gKMj44mK+DBZPwcDgch/F6jOYOlhSFCQQooJI=;
        b=o1DIJsSN+DGBcNYulm4rYFTQ5TDyZzZOiCYw4Rz5ZcBHrK1lCtipoLY7gKbipIsdFF
         N0jHurSgQM2ho5S+NqG2qtsnG2HVZxxlsG5DEHcSwk/5Jw/mAj7U8bQVKzeZ6SWRW/Hj
         5a7f2W9SIZERildJcXC9udVNin0wYJPx8fUjOlSTPP1/XxVSPgmUhUPOWwa7mEYA+Thk
         JviJM8sdvswIghV9Kb2gCPZmRav1nSz+VgZ9iuX3mmA/htqIFalDcD4DtFuBMEyl47gb
         qTeY490Zl7qnkWuJHz/oqQVnqnbND2okyIBf4pMrkGlxiEiyFm6I0SLTfl/Dwzx0vUmm
         JYvA==
X-Forwarded-Encrypted: i=1; AJvYcCXhuRGaMOGedUHrZ8arTnGgo6XYDH4ORvlisDN7urfP/G6OXkhG1LlwHZhSp4EgIz6JSaS4/Yy7g2Hxk1Phavd0AMb2gg+x6nodQjcS1CtSJY+KpPLJbv83zvYQ
X-Gm-Message-State: AOJu0YyQDpoYhTrr2Et7JJVcLxeT+tmiJzEiAttM7gkTPpuVoMpTyI7q
	g41Kr0ed7rVpSpTIWzUtFvUzEvoXZ2VbD/+EYr0imWZ+SnmUyOls6LW4N4TY6O1zy901XyUvO61
	LZhXijx77uUVm/8C5lGf7ke0e6kM=
X-Google-Smtp-Source: AGHT+IGO93Mz5Yrq+Ung6+leuBDTr4dzk2/EKk5O5ykcgv0u3qZGH81F4jSxktWUki8wPKCwF3dvIKKj5fHssSz6q3E=
X-Received: by 2002:a05:6512:3e1f:b0:529:a161:4781 with SMTP id
 2adb3069b0e04-529a16149a0mr734837e87.7.1716564823004; Fri, 24 May 2024
 08:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <316306.1716306586@warthog.procyon.org.uk> <20240522-weltmeere-rammt-70f03e24b8b4@brauner>
In-Reply-To: <20240522-weltmeere-rammt-70f03e24b8b4@brauner>
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 May 2024 10:33:31 -0500
Message-ID: <CAH2r5mv0x=PT-nfWbybkC5HiKHKN+-KS+Quk81_MEpnY4dpsVQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: Christian Brauner <brauner@kernel.org>
Cc: Steve French <stfrench@microsoft.com>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can add my Tested-by if you would like

On Wed, May 22, 2024 at 2:14=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, 21 May 2024 16:49:46 +0100, David Howells wrote:
> > Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> > than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense =
of
> > not waiting rather than synchronicity in the sense of not returning unt=
il
> > the op is complete.
> >
> > Without this, generic/590 fails on cifs in strict caching mode with a
> > complaint that one of the writes fails with EAGAIN.  The test can be
> > distilled down to:
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/1] netfs: Fix setting of BDP_ASYNC from iocb flags
>       https://git.kernel.org/vfs/vfs/c/33c9d7477ef1
>


--=20
Thanks,

Steve
