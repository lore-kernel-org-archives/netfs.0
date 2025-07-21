Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69810126C03;
	Mon, 21 Jul 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058645; cv=none; b=Z/Gh3HlMVOp3LUHOsq7wbwqJCxdSrPILXsV1MSZkX7kKulkDhrGSShZMV4IIWACfwhtQ2Dg3nyea2RkTXkQYB/xNkmnhDQ7SKI5nJCs52mEDSAgHb89NDeEqxCJ1rUlzR+TVL64AtvYQV56YlR5AISj6/Rt9INP4odeRdWC4vDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058645; c=relaxed/simple;
	bh=sZh7nAa2H+zz6Rw4iCplFxXECYnUeug3lpaO6Yshh1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz00Wclb4UkaU6D8od1fwIH9l4kQbtb4WRQ03YBR4Ztgv8LUlr2zyWEubecSdTp3YJzeMXRKkCA22WZVu4pQ4z5H84G3p1cqI8YXrQCWyaKwc2SGVJE8+BugKWaWX19Vc/BY07w5+uIqwhJuNDFNYHhQ8FMAiTWcR3RY7Ut+pFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOM0Hxbs; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOM0Hxbs"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f2ba094dcso1786468241.3;
        Sun, 20 Jul 2025 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753058643; x=1753663443; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=WOM0HxbsCLbhRIcryhHxjGqnWWV1+mkbFQ5h5TNB1jZ6rqyQpFBLFY92QOyHh81tQt
         0MRjtdzi32bKVlBWlX7J/2DtC6ETLK4cuu/GYZzq0423ZhwtbloBmZdlAb1RxiWT5Iki
         KYKHCkdZ2PL6DOUtug2OcS7MRyaetRjbG5o9aCLFjGlAiaJs2jb7HA+gX4wWQWJNMFhm
         XRGWRmbp8g/uAGbmBu9TUYaFSd2rQNFwD+fYAK8NCh1BuE1QVYfLuTZYI8J80Zt28RK9
         K1oXay39QA5AGuyrMfMrhsBVqgbtACCorLZMaqkWE+qL9VhIxzexHz5lCCn4rla5bajC
         ktyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753058643; x=1753663443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=vLK20oh4a/wscGHccFi8KJ0k6bQHd0Whxhwh3HlDxmUxT+VYPjUDiE5q7eHh7Cjc6J
         pHUDdrkle3sk+gJTwhLhJZdVvCCHf3OprfX8VRqK3p6g54/JbBIps+lGh1YwbGvfal59
         6CPOPEh5Lafz9KK9fL6GEKPYSwg+o2MdKVJ4jHTHdx7izoh/DRfzE9NTSgH3pqXfsc5t
         QUfEHFZcg5gZnZoaDEe6ggw6lqrxGxBKNAH+36Hm12pZidhcmHmhbsJMKTSoj0bY3+lf
         e+4zjyBUWuYlPm1sEDkTgltU3JC6SLxKw6iNHvSYkSymaDB2w85PcV/HhlzvlkLBxZGU
         q9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrs9R2NN294PARjmVJg8gXVkzwcr3+etsTM5zOlq7GCF9iwfnC1BKzQCElirDNJSvARCyjHAE=@lists.linux.dev, AJvYcCXhLHFCoPqN8mk1LnKMWk6mscXq5dsR1IipKZ67I3NYgWH6CVkSdX+1xan6ZIHnWBdiGq/uNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX1+2pua81hmX3rf39LzMgCByk8QRNFYHgFkkSvoVs4waoVh7c
	zJ06gJ5R5w5dJXvxY2hJCVOmr/2otDVrAmidwR1u0WIW5uaNVFXe2zPJMQqfnZLDyQaRPLVfx46
	dtV6IliEK0nbgW4/1mnd+CgiCqxuXR/s=
X-Gm-Gg: ASbGncsX8/5DqsRTwVqoNVLz2zpUZAS40JuBlocYB2XJVTfdTZDIcLXCB56BNWnjbIx
	mbbYrTZsDlD241lQ87t4hiN9sGHoyzYaQ9lguCjimvW9JoQGp7hkP/G6scIpmJ15HAqkjUK7Cj0
	X6el1MMYJwzKOjMv06MelzvvoXQS8JivCi0bIMygnCnWeViD7h12pYmVEUyosFmY+N4FmvQcgJF
	89ctU4=
X-Google-Smtp-Source: AGHT+IGFRYyrS35WTP3i9Qe8TXmZslY6x6nCRq1gIJA/O9dosgodOs3uPYD7WXYU49lcEb5mCGS05wblqRqGVV/3QiI=
X-Received: by 2002:a05:6102:6316:10b0:4f9:6a91:cc95 with SMTP id
 ada2fe7eead31-4f96a91cec6mr5610145137.27.1753058643165; Sun, 20 Jul 2025
 17:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
In-Reply-To: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 08:43:51 +0800
X-Gm-Features: Ac12FXzyFbI4GjwypQZFYPLAZaBnNxcXr0fPPaJY0y3WB9_zSNUgD719YOscIeg
Message-ID: <CAGsJ_4wOeBwm2=1CbtZk+gHXe0wVyAYZuV-RZcV-wXe4Rj+h7g@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:32=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
[...]
>
> I don't see this will work for EROFS because EROFS always supports
> variable uncompressed extent lengths and that will break typical
> EROFS use cases and on-disk formats.
>
> Other thing is that large order folios (physical consecutive) will
> caused "increase the latency on UX task with filemap_fault()"
> because of high-order direct reclaims, see:
> https://android-review.googlesource.com/c/kernel/common/+/3692333
> so EROFS will not set min-order and always support order-0 folios.

Regarding Hailong's Android hook, it's essentially a complaint about
the GFP mask used to allocate large folios for files. I'm wondering
why the page cache hasn't adopted the same approach that's used for
anon large folios:

    gfp =3D vma_thp_gfp_mask(vma);

Another concern might be that the allocation order is too large,
which could lead to memory fragmentation and waste. Ideally, we'd
have "small" large folios=E2=80=94say, with order <=3D 4=E2=80=94to strike =
a better
balance.

>
> I think EROFS will not use this new approach, vmap() interface is
> always the case for us.
>
> Thanks,
> Gao Xiang
>
> >
>

Thanks
Barry
