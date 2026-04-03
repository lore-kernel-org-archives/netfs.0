Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB42EDD62
	for <netfs@lists.linux.dev>; Fri,  3 Apr 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239995; cv=pass; b=HzYp0EeZICe83J8xJQ+3gfeBxz0+7dls0Mjxmdccseg4ZQBTW6YMm9Kc0VxCmRVTJesI6+THy6LpkTf5/a0XTDDg9iOrnI85b4mg/SAifXjXKbUe/DgVIZM4YZhRiWsLuWKwD0Do/TXBz//lt8Kcdz93gCrS79AZMFhKCQHusHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239995; c=relaxed/simple;
	bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmhbCYMjfzMNLYN3IVvXv4vZsYxz1YWNejf1QdMjlXplS23E6mIQ8HO69XcyP2ao4qF3RDdHS5cEp6oVtT1OYoQfkv3BFKfZkkN0puEtrFoudcDb/anJKnbERw/cX/p1O3vCawT7IbtsAiki2/XefE6SBNK7AX1NRXi0W6XFjy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BhzcdlLw; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BhzcdlLw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b941762394aso280618166b.1
        for <netfs@lists.linux.dev>; Fri, 03 Apr 2026 11:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239992; cv=none;
        d=google.com; s=arc-20240605;
        b=bUo/m5OoCUrR5KuS7bWdraZt/n6BCINOjcOcSd2WqqkpVhY+9E4ZcEa4sazrwFxIGP
         P1mZJpKn/a9StR9E2Im7E4g4YJNTO2kQKZCqBL2UvhjQCGkO3TXR+dnOkA2Z7IX5O232
         f1RQ3RpzcIUB8bBdrX3DHozN08BXmk7DdELlHYwEYE5ULJ6SIaLKTQZ90ASH0GgAA+aT
         SAp2XXUMD4m+etQlsQRbY/NDUZVhzflCws2VlhvKV/64lB+Sql+2+Xg+aOt4bgMb0eDG
         79XCM69Ep/ZWOtQ94CvSWUMIR80/MHX8f/2OkJqim/i7TeeLq/xf8DyqtDbpvKdyk4EW
         2FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        fh=bTROiw3JujqitdQdOjCvIPup7gVelANNVWBfOXqT8QE=;
        b=kNylhJWdDDEbE1hVdxrPmKz/Z/vphVxtkrE6jtxotBE5orstlhN0nCzGGymqkDGFv3
         wKL/bks1ITawOo6H68F78OSBABk4Y0zeAhdUrulJV31Jn0FDXs/oLNwds4Rf2PbttjsN
         RkFOJjsAWwJhE09A4iTvQDEJhSPAoeS7mlmqGtYSwHLjytHD040GsU2m3ReBIuj6paT5
         ase49P1ZBnuqQ0OY1mvkrDLobcuBE89N3zCXsOi+IZQ8uPNgODaEazdiqqr6vx7eg9nt
         AUnhnF0fJvCk9VNkB4wQc5G6Sddf5fiX15/6kxyn3GaasDpsEst7vTJsTu1rmKyvUT5j
         7j7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775239992; x=1775844792; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=BhzcdlLweLW94AAzwMHl7uE8O44uvuJUGKEgdIljyzZXjeoJLGZUy42WLKvRWLmRIj
         OJeJkRFa+X+iMBkLSVwPr+/Wd8yGbKSrDCc9Mn8SzC3aXviGw9lvm0/kG81Cg+z5BYKF
         Nm9Qcp+71JQiFtc7bmsyX5lUfhtcgzAbxNYmQDRdfISx/5fKtWsNY48pYsinFic9sgZY
         eckT7F003YTnTifRoUIqh5BkL8ptmTAIriftlZU6VWfsLz2Hb0/25LyW1Fovem1SklCa
         573M/h4KXQF0/nVMlIULBPTmQc9Dze/t2/VMrfjnoVYQjuGcv1LqxqhGJt6j34zCvpNi
         ObTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239992; x=1775844792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=Rn5p1C4IwR9NW47sbKGqBeFyEA7AQfBUxw3bgF+qy28I5bIoSr7eYnzdddxF1llvV3
         Mv6L0wmYqepZRXj8ZloW9c+IR71Y4pin5Wd1X4oy2c0KU8qmScsvfMdKSKWCaQZFs8Np
         TrkcqXOmW78RsgQq4VaxHnYsbQPdwcwEllSGB2HPTLhiMA4F0/qnOEefk6x29D6pXCVS
         ejFmznvohy12EID/ZhtTgifVhRxijTlsR4yYOhMTlC5s6VjJ1d/4/3cYuJCC5zGyPH26
         XcdowT/8gmRSN87DhC0LPtrdqOjbjVC5tuzK8SuvWzuN66HCfdzZyHXDI17Y588dA5jr
         QGdg==
X-Forwarded-Encrypted: i=1; AJvYcCVaEdhsbQzaDWbtNxEGUlEc6rAA6Xsjw/ntw8wE1FP6Hh2PF0QBggcJWr21Jh8Um8Mu7EDxNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTtcrxkwSMSb+DyQ/UpHxna+1vhWFHMI4avsCGVhdYe+yMgwnQ
	MtwLi5DG5e1UWfhR+T7xDSNbWght61Hx0KJyNf6qpGWWXaCm8vmcFyauwOOZi+/v0R9g/lTxpNL
	RrCZnbOWuuY3UgHhCAJPxkvYXpw6asdIRivq1Rja8ug==
X-Gm-Gg: AeBDietAkVyGUswyAIWqx3xOhivbysxfGe40akbjTg4EL5XPDX4oqKAkHXRGsjA67GS
	C0VZf6n9XqUmW2GW2SQ5KoDiNmu5FZ0TxzgF7TxN47zM6vKea30m7lVa/VMH2N9zNaY162QR3DF
	zFmI6SfY150rWv9jiuVcE91zKhRX+SgNc9d9leCg6UDbxTxvnOmNyhHG5j1ZXPaiW3kibKty3Fb
	5a65s401prWzmwKffwiklvO2Tv4BfxyIGzCjC/jDVspPhg7+evDId82wHzELUObLGYWQhO/Joxm
	Eno4FVjYdXJVbqLxXW5hyGniXpgBRitMgZIe
X-Received: by 2002:a17:907:c002:b0:b97:f22f:43c3 with SMTP id
 a640c23a62f3a-b9c67951924mr190315866b.31.1775239992468; Fri, 03 Apr 2026
 11:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com> <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
In-Reply-To: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 20:13:01 +0200
X-Gm-Features: AQROBzCml0wejgS8KWhp_lEvInrGoAcd3uhJWZZ3HEky3MQRfu_mu4yL7bGyHI4
Message-ID: <CAKPOu+_ghf7cw8zT2K-hyKhdWiFaQss2jFQ-JsUUPBU0MmSFfQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:18=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> Why the offset is not good enough?

Because the "offset" variable tracks the whole write, including the
folios that are supposed to be omitted from the fscache.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
