Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E27306486
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150526; cv=none; b=eMlNCNQiz3O6cOoOAuBqG1IUuLIqxz8+O189UL6QlOUuTkvSw7MxYWMg8QP7CyAJFJGps7FY8M+PIKVaGzJC6YcF68zuRsI5XP4SiFaNSOCOinrekhLQGuIqA5aWqYVd2QIZyt/8RKzMfGO2qeziw/HWG49w+2bllL8yxaahgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150526; c=relaxed/simple;
	bh=fiHidarY3es8NBA+LEW3pv6bjjvuMZYa+mJzlo0B1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAWTN5hOQD/tV5w4ZJyB9H0Nkq5oX8wlT0vhKdWy1UrivBmd7cd90fM/45aqWsDDkwmd827zjvBcdWnplObnjlUI1COICxdb1g+CMLYtGmNgqJyR44Zx6MMLYaGacnf/0R5XPwmCJplX66vQRJwfnh4go6/efzmkcx+gXDM0A5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlnKWBmc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlnKWBmc"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0473327e70so55966766b.3
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150522; x=1758755322; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=GlnKWBmcC/9vaisyk+QaHJJ3H7egU5iequLDp5fJnEstcRyJnDSKwkP0RFEYVhfhG9
         aZVZtc5L3DgR2W30+qwJJgGc0StYAub175jmRfEkmqKD4t/JqiDowu0o6zyOoM7mkzKA
         Z3Vx+fOUtF/KatE/Oqy6uNPcxhKFEi+zqtUu0Xcoe3qXRJrejvqrGcx+CrbK6h8wVFwg
         6OUmdXvOmw47Dan47C5lx9Ag+JIFLQuj3IgkPDl7oMeyP2ciJAPwvOEHeJrPZFfQdgZl
         Z5xDKQOTA2BDccFVYT65mbPM722qWuYgGg0e/h6C70S7uekscdPQg2lyY94nL87CqWab
         yQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150522; x=1758755322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=NTBHnY3cNnOARNv9EjW+4VOyk1X99NCslJY/XCj2T62DDlGpbFpJ3j4ZAw1FbqUX2K
         8+qxswx+TdWIeIZ94HSM8kk9poP0MHzAYBRbf2bE8o56wrLwWvr7RcDw7py921Mrr8Gh
         mdNQGimPrOrq5Z2wMPI5zCe/yfjXyReIXAdCynOKxHjBHoD+guATjeQGbuI9qVQ1X5Mb
         2aFPpQhhlxkmuwD8C+hYQLDZOqaMiPL3+0b9zrcOLiNxrtfxg9D5rlcWTGWd5/BjnW2R
         Z+358rUivFzepi/fua6tCVqq035fF7xonJUAi/+5V4zSh+MZLs+x8Er17+xLphsJb4GH
         cWMA==
X-Forwarded-Encrypted: i=1; AJvYcCWReyj2OX8qoHtqk4f2pTLuwXuo/ndGIkeUKkMIIR3Lm6LbK49fyIt3uEMHYQRxFKDg8Lwwjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/16UUwrSbCvFuO29UCtq1kvfWzhBGVnvx2BqQsvyr+eDnTWeV
	eDdRZ+chQwmIIS5utMreb4SmYDHS5UxxADCflFL6qIEnU/3bwfLZ+8tG3GNUpxCWETAs90q0ORM
	+2rH/hnmm2r5h27dyVKWAselCvc+N7/Y=
X-Gm-Gg: ASbGnct/JhrJc/uoemTKggEVVLInew849E7+V+lBYWnChq4M7PDqscQ2AP/SC+ecm7i
	Yeb9Ln0D/k575ZBgU7ik4LvpVdcwfXEesaIibiYIaEMPp/7g+0fizmavSX3nqYoullkCm3G3sPe
	UgHJ3eKR8D2qHOzNhHGFGTKR+Gn9Qigahs/7s6q80u/moaF62fanqDzuuttBqI8mbZ5wg0/1Ttf
	3yN42GzV4R5vFmKMqB4ZM/OFaISt4Jt3dewlTG6CAoZhgIkG0xVh16MkQ==
X-Google-Smtp-Source: AGHT+IFTShsh8t7nrREG3sNteTvvDWCztpJ0irdoYHone0kblikor9dVjpl7/+XtSzyEetSqaaCdKn/NmlZEPTV0vhE=
X-Received: by 2002:a17:907:6093:b0:afd:d994:7d1a with SMTP id
 a640c23a62f3a-b1bbc545b99mr380535666b.63.1758150522536; Wed, 17 Sep 2025
 16:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 01:08:29 +0200
X-Gm-Features: AS18NWAPWaGTXxRYRzp3XafBT13uBoehIcp4zLeoIa2AaJjHnaVuMpyaFs-UzhE
Message-ID: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.
>
> All that adding a whacky async iput work around does right now is
> make it harder for Josef to land the patchset that makes this
> problem go away entirely....
>

Per Max this is a problem present on older kernels as well, something
of this sort is needed to cover it regardless of what happens in
mainline.

As for mainline, I don't believe Josef's patchset addresses the problem.

The newly added refcount now taken by writeback et al only gates the
inode getting freed, it does not gate almost any of iput/evict
processing. As in with the patchset writeback does not hold a real
reference.

So ceph can still iput from writeback and find itself waiting in
inode_wait_for_writeback, unless the filesystem can be converted to
use the weaker refcounts and iobj_put instead (but that's not
something I would be betting on).
