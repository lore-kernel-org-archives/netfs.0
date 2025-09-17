Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6022F7444
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137165; cv=none; b=PpWwF8h0TmmNCib9SR2OGi0E/7v02KToQI4RZSJc2ZR7Kh+s0DkPiTc+Lz7oFRGZG2pasJeftbLfEMzo/KKPp0JMJ1toPEyNorgi6CR2jZ/BEpQ19bz1v4fLcWwp16vM5t86NPYq7KtJVUuMqg95DSwMamLOZ99XxSH4f6tXNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137165; c=relaxed/simple;
	bh=rnRQh1fgG/iBS/92Mk0NI/PnJazDMk7alTWmgTAbA0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uymi26DootIG0Y9xzTd9f4V+oZVKgJ1jCC81rZzS49opwMfatVW4k49G/78kTwdY4pU1QJLEeVPRlm4SQ+XPfT9R4mHFL0xPxznFPyrdrAcFdke2Q0iCCvnrnUi3PJjoQHPvzThDEwWam3eFsEp0/KdhmMpzw9SJWqh0dU68V+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AMvLY3n6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AMvLY3n6"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c28f390eso27499666b.2
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758137161; x=1758741961; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=AMvLY3n6VJu/34RupGlOmo04y8cWgtXaq1pgxH1NJQ9qwQNf0O+sU0SyI6FfK/0Egt
         /BTDSdNRziNbzdD7lq84POzw3zQ8LZSnGAOd0rfE/50r0jardQCKMkkGDrTJ0KCm7wIQ
         WzRg7YC8x0iNhM3u2Jles74WVLh7aExFFSeIMGjDbJJTQit6C+MGLBdDrAO0vbPjdMmi
         BiiL0l60CJ5+Ep49+V/5zNhEnCyNNWVsJe5vU4ZAezS1gmRZFqD+LCfKqWcszWZlDh4b
         xp1I8COMMHl9ErW4Vv9QgRPJ+OgqpxyBo/QM7+uIlg9b4XsvfoDr9YJuorUeTA4SbPwK
         FAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137161; x=1758741961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=sdVs8efckDABuNhs7Mu2RYROZ0s9Z5qAgamOY+Hi71XTqim0yx3u441x9oicJhWzZk
         T7oPFQtR62wICzCCn3GvmJX78rXu9hUHg0afo5zm4aHnIgooWKTQtGZEZrt7m7ac3RZj
         8gljdchN1QU3tsfBHKODReiD83mv5F3rtrmEu5/xaVqj+zqn9Yc+kxI5XcYwfXe5tmJq
         EjVfTXx5Yuom+cu5lcr6aVxtuyxnqVVp6iqUCs2QBRYpuV4VjMBLYb5Q+Hob9EkGrdRQ
         NWy1bJhJU5+3f1SyHkm+22ZWkuSoP9+6yt2584j+Df8XnkCoWrHpbCH3k1Eo0JikLV8Z
         TJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUo71bA4+sFv73//aWeUMK4204+Wlo6HEqvHiGG+fQnpWSCeyb4/96w/BKvIlwuescSCfBfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5IMDjh2FEffF5S2Z+Bk+qujqgXNZ8qB47Y+KNXZvXQZef8+P9
	kQ1UuidEaSKRnJgRfg749/WZdZASmumyr1M7aNHCa5z55URGldEaze9Gu83gzwPv30Xb4MbMZzm
	WN52p3V5X+TQF5MNr3a4u6HGEUGbTTTRv1zBB3Cy20w==
X-Gm-Gg: ASbGnct5i1YDGlPD91Iut7SC+9QcwqUEUqSVWQZ47InFDtTH3NK01TlTsQ1/kMzdzmJ
	IdiKW200sorr6Y0rXTFtzpOePdoXfCweU9D91S/WRjuJ74+IfF4VQNpz+AQopj7OcszqgTFDjVu
	rUhXdD20ZGfj9PishY4Mmto+rups3ii3mpwkX00sHGFeUpzuFAe+m4SkGguaaYyaqZ685nROzfx
	eU0J/GSm3WTbR4Ljtg7dxnB7E0wHLXFPl5C
X-Google-Smtp-Source: AGHT+IHV+j4kzgnlA17vMPfFNZMuPAmy/0tGoISSJII60cK9xhE9rBFeexcHdz76p+ynPHs9naBObYA9aHQI2oTrR4o=
X-Received: by 2002:a17:907:944f:b0:b04:9468:4a21 with SMTP id
 a640c23a62f3a-b1bb739e7f5mr341249166b.14.1758137161567; Wed, 17 Sep 2025
 12:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
 <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com> <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
 <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
In-Reply-To: <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 21:25:50 +0200
X-Gm-Features: AS18NWDOAnSLj0nw3kPAv4b-NSgo8QkEB21FLGzoG6YC2RFaOsN704wTATLg6Fg
Message-ID: <CAKPOu+8b_xOicarviAw_39b2y5ei9boRFNxxkP19zE5LGZxm=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, Alex Markuze <amarkuze@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:20=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > > > +     WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inod=
e_wq,
> > > > +                              &ceph_inode(inode)->i_work));
> > >
> > > This function looks like ceph_queue_inode_work() [1]. Can we use
> > > ceph_queue_inode_work()?
> >
> > No, we can not, because that function adds an inode reference (instead
> > of donating the existing reference) and there's no way we can safely
> > get rid of it (even if we would accept paying the overhead of two
> > extra atomic operations).
>
> This function can call iput() too. Should we rework it, then? Also, as a =
result,
> we will have two similar functions. And it could be confusing.

No. NOT calling iput() is the whole point of my patch. Did you read
the patch description?
