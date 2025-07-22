Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB228B4EB;
	Tue, 22 Jul 2025 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156468; cv=none; b=AUDCJYr/57FX1KxfPHqQXlQbjEChuqm30AdFfAnuaDYwbL/d52Zq4LqgNhF6GhDJm4eVM3AWSbRTXzhomhx0b2TYD4VA7D7iVphpt7YP1MnPezIQmiiEphN1XVt8VpE3j5vS/4KC6QpAsGX7zRgU3iarsC+29FWDKRmt+zd0Kd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156468; c=relaxed/simple;
	bh=pMF5pqseEWjPYxGMLMeAr2jDTsuh1B1VIVqreXIt6BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiRQ87qDB9IBgEgXadOap6MiVXPOdNFrlbU5HaSfCM4/ioKVtLzBH7P4Ry0X8DtbwwJRO+GCjvif9+j+zYNWTMn5k1AzrlrgHaJTnVWbsNijw4x46e4SodABAGsw4C9J90CudwbXBaSR19ywUhQGIT98PlxK6MLrkHDon1EcFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKW1ZuR9; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKW1ZuR9"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5313eff2649so1307254e0c.0;
        Mon, 21 Jul 2025 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156466; x=1753761266; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=FKW1ZuR9naSLEfJYdZnKcd+H4gEeM7Jie+NLvD8Wt14Yftpi1XzplOY6BS8zR5TqM8
         CU7aeQHPS1L/gkSh93x3nyzEkIYJc9ZQtziWpvifwtkuC4JYa4eMtQYbKDkdhJU7cKtb
         FghvX9q6OTD2IUWQHAf4NpmKpfa+3JT8uw+MW4UHQ+FDk10n822gUuKAqukmxrKcb96R
         cmnYeLaq9WqtYyChl9Hld/qptp2jtAnyjfL3fVLOMpNLvDPMdtUMZE4SFYT0AmN0ckbA
         nyuaQl3Sv8z9EZ/rq8eSt0meeTdhQt6hjz4PePfAvZOx+TEyvT/wA6tDN9w2gcJEJDdW
         hgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156466; x=1753761266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAAlykKu642VPrQqfIgQ/sSqAoZceoQZhIURS8zROzA=;
        b=RVdBkD8BLwEE2NvYnrCe3WwjmPWjU+JltKLutZwaHC07UYbFROH+d9lkz1ZV87C6bE
         IpXf+nIfBikYaDkFiIka4KIqJvAxGlI+B2VirhOK6TW9tt8uSXxC7dNBo04TIpEhny6v
         XrTXXwTkIXkNWqsff9c9hRHLGHUu+qyqmAjkw4uYky+so7SPlh+03nn2idJsUfRjlXPx
         kP8GnBuM7m9JKwjcKsWb9PWGSvoLrb5qufrGz2uXXKCGc48dCEZXhm5OD93LCaCO7Y1j
         06g5PrkCOmzstrhQfBiU8SO+Mh3ylAS6uDNFZfHI89AidiQZ6CNPLny+qzYyxVsHc9Gc
         dpNw==
X-Forwarded-Encrypted: i=1; AJvYcCUSyv1YKbP6WZdiYX66InnrE350X8UQXE885ha09tUGjevKYf6X3jhSYRb463xBN6/4lT9WEf0=@lists.linux.dev, AJvYcCVHRrYEnt8iy1ugvmkZt2dHGxpaXoZOJHQBs9nDw2EDeiDSeOocyRUUhGV+Ps4dJmWhZXldzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRsI90hWZSEHxbX2YyEreiOfcZ7xlg83njkXmmj0X3dMnj9TsQ
	AHay4lIzfANEf717mBeZg0r4V8KELxrhOjJ1Gn/cjwo1sgADHGsfF1fea4Zez826h8Ze9lXwlmH
	cNblFlIFwapuR57YIlNDmFZFSiBUN7dE=
X-Gm-Gg: ASbGncuJ6DNF21WJlw9f0IwtxjmxbY9qHY4aDYV5AKDRDyjUhK+vnRBBYa5bGhSlJhA
	oXXI0R+/rKlFEyq4dgaEjOJemP73gV3Tkytp3wVWTKR0q/8T9GkRhVGw7xv0n0G784JZKnfpVjr
	GH2d4w+yYyR+KH1YP1tGK2b054Z39NopD8Y7OVqfS3ZrTAUbuKnbg4lO+V/mnhQLcfbhDpr0p+C
	nGWq3w=
X-Google-Smtp-Source: AGHT+IFdEM3sDnKSU7djtnY2X77gIkWr33PBhDuXfdQIDGEOAUgRW6b8nyrGT5SpWkQFjiRSNtgM+8Lmi+axf63N/6M=
X-Received: by 2002:a05:6122:4d0f:b0:531:236f:1295 with SMTP id
 71dfb90a1353d-5373fbda52dmr10043238e0c.5.1753156466033; Mon, 21 Jul 2025
 20:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com> <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com> <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
 <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
In-Reply-To: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 11:54:14 +0800
X-Gm-Features: Ac12FXykbYYT14P53wpCeHJw2yoMEcQU-j3E43IYKsTdPACdf43QFDrlblVigVM
Message-ID: <CAGsJ_4ySQFzSbXZzecH9oy53KFpVsoaqXThPiJxfYUJF3_Y+Hg@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/21 19:55, Jan Kara =E5=86=99=E9=81=93:
> > On Mon 21-07-25 11:14:02, Gao Xiang wrote:
> >> Hi Barry,
> >>
> >> On 2025/7/21 09:02, Barry Song wrote:
> >>> On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> [...]
> >>> Given the difficulty of allocating large folios, it's always a good
> >>> idea to have order-0 as a fallback. While I agree with your point,
> >>> I have a slightly different perspective =E2=80=94 enabling large foli=
os for
> >>> those devices might be beneficial, but the maximum order should
> >>> remain small. I'm referring to "small" large folios.
> >>
> >> Yeah, agreed. Having a way to limit the maximum order for those small
> >> devices (rather than disabling it completely) would be helpful.  At
> >> least "small" large folios could still provide benefits when memory
> >> pressure is light.
> >
> > Well, in the page cache you can tune not only the minimum but also the
> > maximum order of a folio being allocated for each inode. Btrfs and ext4
> > already use this functionality. So in principle the functionality is th=
ere,
> > it is "just" a question of proper user interfaces or automatic logic to
> > tune this limit.
> >
> >                                                               Honza
>
> And enabling large folios doesn't mean all fs operations will grab an
> unnecessarily large folio.
>
> For buffered write, all those filesystem will only try to get folios as
> large as necessary, not overly large.
>
> This means if the user space program is always doing buffered IO in a
> power-of-two unit (and aligned offset of course), the folio size will
> match the buffer size perfectly (if we have enough memory).
>
> So for properly aligned buffered writes, large folios won't really cause
>   unnecessarily large folios, meanwhile brings all the benefits.

I don't think this captures the full picture. For example, in memory
reclamation, if any single subpage is hot, the entire large folio is
treated as hot and cannot be reclaimed. So I=E2=80=99m not convinced that
"filesystems will only try to get folios as large as necessary" is the
right policy.

Large folios are a good idea, but the lack of control over their maximum
size limits their practical applicability. When an embedded device enables
large folios and only observes performance regressions, the immediate
reaction is often to disable the feature entirely. This, in turn, harms the
adoption and development of large folios.

>
> Although I'm not familiar enough with filemap to comment on folio read
> and readahead...
>
> Thanks,
> Qu

Best Regards
Barry
