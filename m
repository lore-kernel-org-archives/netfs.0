Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9121FAC40
	for <netfs@lists.linux.dev>; Wed, 18 Dec 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547701; cv=none; b=ZKlwuw7PrUf02sfwcoy2hX0YskGAsUaahLhmfQ/f6oxgkv62Zd2ZngSivvN5FapBGeCliXbYA+KvqgRAztrOGeqwyO6scqcKeY85cOc6269JDlwmG6P/jJiO793gitAkevhp4MXItGb2kYQbaEmG0Hgi40dBeis3MOAIgfPQq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547701; c=relaxed/simple;
	bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRkRAsSLyDMRIU3wVqdWkZXyffTruXqLfDMd0rWWbO/lzSMZDXfxz6GSXH6tVlALf5/OV7gkde8XTHw8PsilmEW3/HHWqJIl2z9+21IjQG8cdWGmz1NEV4sUEKC0LRveAtSmAlXI/ZXuUVyWKQEXsnCcLMz5dx1A92vYnunidsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeZENIgW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeZENIgW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734547697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
	b=QeZENIgWVNgGBrm6aYbEZsU/xhzw7avZlZTWO5nt+Qh61g3prL0q9aBJb5gJXxLMDHMoFK
	dVgU8snAOPIGvEVJYJxwOjyfRQeYIlAJxYhW+JBE+8o63JQuOsq3bTOGgqWsosf9eZw5r3
	7jx8zLRDqVf7CfOsyee2rgzd62ANzAQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ns7PwSM6PG-iHNEBne0-cQ-1; Wed, 18 Dec 2024 13:48:16 -0500
X-MC-Unique: ns7PwSM6PG-iHNEBne0-cQ-1
X-Mimecast-MFC-AGG-ID: ns7PwSM6PG-iHNEBne0-cQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-468f6f2f57aso37306841cf.0
        for <netfs@lists.linux.dev>; Wed, 18 Dec 2024 10:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547695; x=1735152495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
        b=rTXIgIs3RCZVIFIX2ygRuZTx2Sd5WQkzy1+nC7BJEeZ0L2tZUKKJy5Z32eUSFou04d
         DfaZzMp9z4R7abhvo2XV1boujxMbG7VjZCO6hdJ0kX0vIc1Tume16rks6od2exCU+emx
         oqlvWk9SVOpQXMa9V3j8LcFvs1BibERe/NnWKVsaKvhTzlUUXK2EMIHL47RJaNrpXJSp
         TzNijcPYHW5gizg2H+um3bLQpG0xlAJ1BhirhLYisQWLtIGoDfqdcFJ+4DSXrQUxUOnH
         Pk4GXfwvn6Za235LBvLPcZJlWT4quF4k5B7FRUm/6Pb0zJuN0roxF2+MMefmGVjjkG63
         nBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJFpoXnyrmr0XlJhEWlFfN2+nsiPOYFR/U3TSAzH5Qfsc+7wSA4Cc07v7s2QKBaDPkShdIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqalFqh2yIMV+sU4dmvCHBafklszDYCNQ1C0Y298MmxAat8mPd
	FRPDnHL7lgA8VAd2wZcLS7TtHMn7yATorB9dswPCKGR5ObyvvuFEis05WOZZxVBtQBOf/k7yKQt
	t9rsv/VQVAVuyp0eUmCp8J1A9lbvSuSqd4Y9TkDBbjFTYE83WyMl5wv65iObLoXqe8bLfA7EL6c
	dFa/Kd6ewYjND4oh6O1xiY5KQSZXU=
X-Gm-Gg: ASbGnctkijGaEIvnkOn/4OdQrjRwqDn+N7xH01MdErzR5wplPA2pTc/7bNw267K41CM
	Ei1TdCgJM146xF239krjYfparQSLaCBb29T5S1g==
X-Received: by 2002:a05:622a:1828:b0:467:70ce:75e9 with SMTP id d75a77b69052e-46908e022d8mr64195201cf.23.1734547695701;
        Wed, 18 Dec 2024 10:48:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTVv+XdS41U4i15obok7wAWPYGesrwGIM+ruomJGBbnb0CVE9F17mMba1sCRuq3dKoJgnBmXNFkG96ND3MBeI=
X-Received: by 2002:a05:622a:1828:b0:467:70ce:75e9 with SMTP id
 d75a77b69052e-46908e022d8mr64194911cf.23.1734547695442; Wed, 18 Dec 2024
 10:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk>
In-Reply-To: <3989572.1734546794@warthog.procyon.org.uk>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 18 Dec 2024 13:47:49 -0500
Message-ID: <CA+2bHPbSWHEkJso18Ua=k+OccZq4HzuOLAmZYTD1d5auDxQ9Vw@mail.gmail.com>
Subject: Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3C2eKH2tafNv8KN4Zx1NsAn2l5B8djGGmtQtTgZb0hM_1734547696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello David,

On Wed, Dec 18, 2024 at 1:33=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Also, that would include doing things like content encryption, since that=
 is
> generally useful in filesystems and I have plans to support it in both AF=
S and
> CIFS as well.

Would this be done with fscrypt? Can you expand on this part?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

